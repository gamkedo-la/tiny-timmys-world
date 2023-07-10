extends AIActor


@export var score: int = 30
@export var health: int = 30
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var debug_label: Label = $DebugLabel
@onready var sprite: Sprite2D = $Body/Enemy
@onready var actor_body: Node2D = $Body
@onready var stomp_detector: Area2D = $Body/StompDetector
@onready var leave_counter_debug_label = $LeaveCounterDebugLabel

var dir = Vector2.LEFT
var leave_counter = 4

func _ready() -> void:
	if !Global.show_debug_labels_enemies:
		debug_label.visible = false
	velocity.x = dir.x * SPEED

func _on_stomp_detector_body_entered(body: Node2D) -> void:
	print_debug("Stomped")
	print_debug("body global position ", body.global_position.y, " stomp_detector y ", stomp_detector.global_position.y)
#	print_debug("body.global_position.y: ", body.global_position.y)
#	print_debug("stomp_detector.global_position.y: ", stomp_detector.global_position.y)
	if(body.global_position.y > stomp_detector.global_position.y) :
		return
	
	health -= PlayerVars.player_stomp_damage
	Global.emit_signal("enemy_damage_taken", PlayerVars.player_stomp_damage, (get_global_transform() * body.position))
	
	if health <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		Global.emit_signal("points_scored", score, (get_global_transform() * body.position))
		Global.tween_eng_halftime()
		anim_player.play("squish")
		Global.emit_signal("enemy_defeated", position)
#	queue_free()


func _on_bullet_detector_area_entered(area: Area2D) -> void:
#	print_debug(area.name)
	print_debug("Bullet")
	health -= PlayerVars.player_slingshot_damage
	Global.emit_signal("enemy_damage_taken", PlayerVars.player_slingshot_damage, (get_global_transform() * self.position))
	
	if health <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		Global.emit_signal("points_scored", score, (get_global_transform() * area.position))
		Global.emit_signal("enemy_defeated", position)
		anim_player.play("shot_pop")

func _on_turn_detector_body_entered(body: Node2D) -> void:
	print_debug("turn")
	if leave_counter > 0:
		leave_counter -= 1
		if leave_counter == 0:
			collision_mask = 9

func _physics_process(delta: float) -> void:
	super(delta)
	if is_on_wall():
		dir.x *= -1.0
#		SPEED *= -1.0
	velocity.x = SPEED * dir.x
	
		
	if dir.is_equal_approx(Vector2.LEFT) and actor_body.scale.x < 0.0:
		actor_body.scale.x *= -1.0
	if dir.is_equal_approx(Vector2.RIGHT) and actor_body.scale.x > 0.0:
		actor_body.scale.x *= -1.0
	
	move_and_slide()
	if debug_label.visible:
		_update_debug_label()
	_update_leave_counter_debug_label()


func _update_debug_label() -> void:
	debug_label.text = "Vel: " + var_to_str(velocity)
	debug_label.text += "\ndir: " + var_to_str(dir)
	debug_label.text += "\nsprite.scale.x " + var_to_str(sprite.scale.x)
	
	pass
	
func _update_leave_counter_debug_label() -> void:
	leave_counter_debug_label.text = var_to_str(leave_counter)
