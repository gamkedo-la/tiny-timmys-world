extends Actor

@export var stomp_impulse: = 1000.0
@export var JUMP_VELOCITY: float
@export var weapon: PackedScene


func _on_enemy_detector_area_entered(area: Area2D) -> void:
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)
	
func _on_enemy_detector_body_entered(body: Node2D) -> void:
	#temporary behavior for the funs	
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)
	#queue_free()


func _physics_process(delta):

	super(delta)

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	check_if_shooting()

	move_and_slide()
	

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.y = -impulse
	return new_velocity
	
func check_if_shooting() -> void:
	if Input.is_action_just_pressed("shoot"):
		var mouse_position = get_viewport().get_mouse_position()
		var player_position = position
		var normalized_direction = (mouse_position - player_position).normalized()
		shoot(normalized_direction)
		

func shoot(direction: Vector2) -> void:
	var new_weapon = weapon.instantiate()
	var player_size = get_node("Player").texture.get_size()
	new_weapon.direction = Vector2(direction.x, direction.y)
	new_weapon.position = Vector2(position.x + player_size.x / 2, 
		position.y - player_size.y / 2)
	add_sibling(new_weapon)

#func _input(event):
   # Mouse in viewport coordinates.
#	if event is InputEventMouseButton:
#		print("Mouse Click/Unclick at: ", event.position)

