extends CharacterBody2D
class_name AIActor

@export var SPEED = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
#	print_debug(velocity)
	# Add the gravity.
	if not is_on_floor():
#		print_debug("Not on floor")
		velocity.y += gravity * delta
	else:		
		velocity.y = 0
