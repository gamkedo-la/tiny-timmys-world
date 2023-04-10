extends AIActor

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	pass


func physics_process(delta: float) -> void:
	
	move_and_slide()
	pass

func ani_player_play(anim: String) -> void:
	_animated_sprite.play(anim)
