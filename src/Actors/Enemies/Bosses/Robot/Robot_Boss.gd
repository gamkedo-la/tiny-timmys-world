extends AIActor

@onready var _animated_sprite = $AnimatedSprite2D
@onready var bullet_detector: Area2D = $BulletDetector

@onready var ai_finite_state_machine = $AIFSM

var is_in_position: bool = false
var fist_is_back_in_position: bool = false
var get_in_position_speed = 1000.0

func _ready():
	PlayerVars.boss_health = 10000
	PlayerVars.boss_max_health = 10000
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
	
func fist_return(fist: String) -> void:
	var hand = get_node(fist)
	var hand_initial_position = hand.initial_position
	var hand_position = hand.position
	var normalized_direction = (hand_initial_position - hand_position).normalized()
	hand.velocity.x = hand.SPEED * normalized_direction.x
	hand.velocity.y = hand.SPEED * normalized_direction.y
	hand.move_and_slide()
	
	if(round(hand_position.y) == hand_initial_position.y):
		fist_is_back_in_position = true


func _on_bullet_detector_area_entered(area: Area2D) -> void:
	PlayerVars.boss_health -= PlayerVars.player_slingshot_damage
	Global.emit_signal("enemy_damage_taken", PlayerVars.player_slingshot_damage, (get_global_transform() * (bullet_detector.position + Vector2(200, 30))))
