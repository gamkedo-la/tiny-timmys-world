extends AIActor

@onready var _animated_sprite = $AnimatedSprite2D
@onready var tongue_base: Node2D = $Tongue
@onready var tongue_line: Line2D = $Tongue/TongueLine
@onready var tongue_line_collision: CollisionShape2D = $Tongue/TongueLine/Area2D/CollisionShape2D
@onready var tongue_tip: Area2D = $Tongue/TongueTip
@onready var bullet_detector: Area2D = $BulletDetector

@onready var flies: Node2D = $Flies
@onready var ai_finite_state_machine = $AIFSM

var is_in_position: bool = false
var get_in_position_speed = 1000.0
var original_modulate
var time_modulated: float = 0.3
var time_modulated_elapsed: float = 0
var is_damaged = false

func _ready():
	original_modulate = _animated_sprite.modulate
	tongue_base.visible = false
	PlayerVars.boss_health = 2000
	PlayerVars.boss_max_health = 2000
	PlayerVars.has_boss = true
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
	move_and_slide()
	
	is_in_position = (round(position.x) == 0)
	
	if is_damaged and time_modulated_elapsed > time_modulated:
		_animated_sprite.modulate = original_modulate
		is_damaged = false
		time_modulated_elapsed = 0
	elif is_damaged:
		time_modulated_elapsed += delta
		
	pass

func ani_player_play(anim: String) -> void:
	_animated_sprite.play(anim)

func fire_tongue(pos: Vector2) -> void:
	tongue_base.visible = true
	var tongue_tween = create_tween()
	var loc_pos = tongue_line.to_local(pos)
	tongue_line.clear_points()
	tongue_line.add_point(Vector2(0,0), 0)
	tongue_line.add_point(Vector2(0,0), 1)
	tongue_tip.monitoring = true
#	print_debug("Player Pos: ", PlayerVars.player.global_position)
#	print_debug("Tongue target local: ", loc_pos)
#	print_debug("Tongue target global: ", pos)
	tongue_tween.tween_method(update_tongue, tongue_line.points[1], loc_pos, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	

func update_tongue(new_pos: Vector2):
	tongue_line.set_point_position(1, new_pos)
	tongue_tip.position = new_pos
	tongue_line_collision.shape.set_b(new_pos)

func retract_tongue() -> void:
	var tongue_tween = create_tween()
	tongue_tip.monitoring = false
	tongue_tween.tween_method(update_tongue, tongue_line.points[1], Vector2.ZERO, 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)	
	tongue_tween.chain().tween_callback(hide_tongue)

func hide_tongue() -> void:
	
	tongue_base.visible = false

func check_flies() -> bool:
	if flies.get_child_count() > 0:
		return true
	else:
		return false
		
func eat_fly() -> void:
	var fly = flies.get_child(0)
	var eat_tween = create_tween()
	fire_tongue(fly.global_position)
	
	eat_tween.tween_callback(fly.queue_free).set_delay(0.3)

	#ADD HP TO FROG BOSS HERE
	PlayerVars.boss_health += 1000

func _on_bullet_detector_area_entered(area: Area2D) -> void:
	PlayerVars.boss_health -= PlayerVars.player_slingshot_damage
	_animated_sprite.modulate = Color(10,10,10)
	is_damaged = true
	Global.emit_signal("enemy_damage_taken", PlayerVars.player_slingshot_damage, (get_global_transform() * (bullet_detector.position + Vector2(200, 30))))
