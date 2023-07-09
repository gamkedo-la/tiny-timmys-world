extends AIActor

@onready var _animated_sprite = $AnimatedSprite2D
@onready var bullet_detector: Area2D = $BulletDetector
@onready var laser_base: Node2D = $Laser
@onready var laser_left_line: Line2D = $Laser/LaserLeftLine
@onready var laser_left_line_collision: CollisionShape2D = $Laser/LaserLeftLine/Area2D/CollisionShape2D
@onready var laser_right_line: Line2D = $Laser/LaserRightLine
@onready var laser_right_line_collision: CollisionShape2D = $Laser/LaserRightLine/Area2D/CollisionShape2D
@onready var laser_left_tip: Area2D = $Laser/LaserLeftTip
@onready var laser_right_tip: Area2D = $Laser/LaserRightTip

@onready var ai_finite_state_machine = $AIFSM

var is_in_position: bool = false
var fist_is_back_in_position: bool = false
var get_in_position_speed = 1000.0
var original_modulate
var time_modulated: float = 0.3
var time_modulated_elapsed: float = 0
var is_damaged = false
var time_interpolated = 0.0
var interpolation_speed = 0.5

func _ready():
	original_modulate = modulate
	PlayerVars.boss_health = 2000
	PlayerVars.boss_max_health = 2000
	PlayerVars.has_boss = true
	velocity.y = 0
	is_in_position = (round(position.x) == 0)
	if (not is_in_position):
		ai_finite_state_machine.set_process(false)
		print_debug(ai_finite_state_machine.is_processing())
		
	pass

func physics_process(delta: float) -> void:
	if(is_in_position && not ai_finite_state_machine.is_processing()):
		velocity.x = 0
		ai_finite_state_machine.set_process(true)
	else:
		if position.x > 0:
			velocity.x = -get_in_position_speed * delta
		else:
			velocity.x = get_in_position_speed * delta
	velocity.y = 0
	
	if not is_in_position:
		move_and_slide()
	
	is_in_position = (round(position.x) == 0)
	
	if is_damaged and time_modulated_elapsed > time_modulated:
		modulate = original_modulate
		is_damaged = false
		time_modulated_elapsed = 0
	elif is_damaged:
		time_modulated_elapsed += delta
		
	pass

func ani_player_play(anim: String) -> void:
	_animated_sprite.play(anim)
	

func fist_launch(fist: String) -> void:
	var player_position = PlayerVars.player.position
	var hand = get_node(fist)
	var hand_position = hand.position
	var normalized_direction = (player_position - hand_position).normalized()
	hand.velocity.x = hand.SPEED * normalized_direction.x
	hand.velocity.y = hand.SPEED * normalized_direction.y
	hand.move_and_slide()
	
func fist_returnfist_return(fist: String) -> void:
	var hand = get_node(fist)
	var hand_initial_position = hand.initial_position
	var hand_position = hand.position
	var normalized_direction = (hand_initial_position - hand_position).normalized()
	hand.velocity.x = hand.SPEED * normalized_direction.x
	hand.velocity.y = hand.SPEED * normalized_direction.y
	hand.move_and_slide()
	
	if(round(hand_position.y) == hand_initial_position.y):
		fist_is_back_in_position = true

func fist_return_experimental(fist: String, delta: float) -> void:
	time_interpolated += delta
	var hand = get_node(fist)
	var hand_initial_position = hand.initial_position
	var hand_position = hand.position
	
	hand.position = hand_position.lerp(hand_initial_position, time_interpolated * interpolation_speed)
	
	if(round(hand_position.y) == hand_initial_position.y):
		fist_is_back_in_position = true
		time_interpolated = 0.0
		
func fire_laser(pos: Vector2) -> void:
	laser_base.visible = true
	var laser_left_tween = create_tween()
	var laser_right_tween = create_tween()
	var loc_left_pos = laser_left_line.to_local(pos)
	var loc_right_pos = laser_right_line.to_local(pos)
	laser_left_line.clear_points()
	laser_left_line.add_point(Vector2(0,0), 0)
	laser_left_line.add_point(Vector2(0,0), 1)
	laser_right_line.clear_points()
	laser_right_line.add_point(Vector2(0,0), 0)
	laser_right_line.add_point(Vector2(0,0), 1)
	laser_left_tip.monitoring = true
	laser_right_tip.monitoring = true
#	print_debug("Player Pos: ", PlayerVars.player.global_position)
#	print_debug("laser target local: ", loc_pos)
#	print_debug("laser target global: ", pos)
	laser_left_tween.tween_method(update_laser, laser_left_line.points[1], loc_left_pos, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	laser_right_tween.tween_method(update_laser, laser_right_line.points[1], loc_right_pos, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	

func update_laser(new_pos: Vector2):
	laser_left_line.set_point_position(1, new_pos)
	laser_right_line.set_point_position(1, new_pos)
	laser_left_tip.position = new_pos
	laser_right_tip.position = new_pos
	laser_left_line_collision.shape.set_b(new_pos)
	laser_right_line_collision.shape.set_b(new_pos)

func retract_laser() -> void:
	var laser_left_tween = create_tween()
	var laser_right_tween = create_tween()
	laser_left_tip.monitoring = false
	laser_right_tip.monitoring = false
	laser_left_tween.tween_method(update_laser, laser_left_line.points[1], Vector2.ZERO, 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)	
	laser_right_tween.tween_method(update_laser, laser_right_line.points[1], Vector2.ZERO, 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)	
	laser_left_tween.chain().tween_callback(hide_laser)
	laser_right_tween.chain().tween_callback(hide_laser)

func hide_laser() -> void:
	
	laser_base.visible = false


func _on_bullet_detector_area_entered(area: Area2D) -> void:
	PlayerVars.boss_health -= PlayerVars.player_slingshot_damage
	modulate = Color(10,10,10)
	is_damaged = true
	Global.emit_signal("enemy_damage_taken", PlayerVars.player_slingshot_damage, (get_global_transform() * (bullet_detector.position + Vector2(200, 30))))
