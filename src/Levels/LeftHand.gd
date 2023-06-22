extends CharacterBody2D


const SPEED = 100.0
@onready var initial_position: Vector2 = position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	
func physics_process(delta):
	pass
