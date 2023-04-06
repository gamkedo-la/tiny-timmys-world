extends Actor


@export var score: int = 30
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	velocity.x = -SPEED

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
		SPEED *= -1.0
		velocity.x = SPEED
		
	move_and_slide()
