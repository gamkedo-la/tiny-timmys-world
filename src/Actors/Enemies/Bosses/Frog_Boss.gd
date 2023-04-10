extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D

func _ready():
	
	_animated_sprite.play("Idle")


func _physics_process(delta: float) -> void:
	pass
