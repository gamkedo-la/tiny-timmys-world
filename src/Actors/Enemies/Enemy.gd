extends Actor


@export var score: int = 30
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var debug_label: Label = $DebugLabel
@onready var sprite: Sprite2D = $Enemy

var dir = Vector2.LEFT

func _ready() -> void:
	if !Global.show_debug_labels_enemies:
		debug_label.visible = false
	velocity.x = dir.x * SPEED

func _on_stomp_detecter_body_entered(body: Node2D) -> void:
	print_debug("Stomped")
	print_debug("body.global_position.y: ", body.global_position.y)
	print_debug("get_node('StompDetector').global_position.y: ", get_node("StompDetector").global_position.y)
	if(body.global_position.y > get_node("StompDetector").global_position.y) :
		return
	anim_player.play("squish")
#	queue_free()


func _on_bullet_detector_area_entered(area: Area2D) -> void:
	print_debug(area.name)
	anim_player.play("shot_pop")
#	queue_free()

func _physics_process(delta: float) -> void:
	super(delta)
	if is_on_wall():
		dir.x *= -1.0
#		SPEED *= -1.0
	velocity.x = SPEED * dir.x
	
		
	if dir.is_equal_approx(Vector2.LEFT) and sprite.scale.x < 0.0:
		sprite.scale.x *= -1.0
	if dir.is_equal_approx(Vector2.RIGHT) and sprite.scale.x > 0.0:
		sprite.scale.x *= -1.0
		
	move_and_slide()
	if debug_label.visible:
		_update_debug_label()


func _update_debug_label() -> void:
	debug_label.text = "Vel: " + var_to_str(velocity)
	debug_label.text += "\ndir: " + var_to_str(dir)
	debug_label.text += "\nsprite.scale.x " + var_to_str(sprite.scale.x)
	
	pass
