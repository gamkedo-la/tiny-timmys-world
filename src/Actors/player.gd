extends Actor
class_name Player

@export var stomp_impulse: = 1000.0
@export var JUMP_VELOCITY: float
@export var weapon: PackedScene
@onready var sprite: Sprite2D = $Player
var direction: float = 0.0

#Lots of movement vars
var speed: float = 0.0
var run_speed: float = 200.0
var acceleration: float = 600.0
var jump_speed: float = -700.0
var jump_release: = jump_speed * 2
var is_jumping: bool = false
var is_grounded: bool = false
var is_onwall: bool = false
var jump: bool = false
var is_atking: bool = false
var is_combo: bool = false
var left: float = 0.0
var right: float = 0.0
var down: float = 0.0
var up: float = 0.0
var normal_fall: float = -jump_speed
var fall_limit: float = normal_fall
var rotate_speed: float = 10.0

var RayGround: bool = false
@onready var grnd1:= $Body/Grnd01
@onready var grnd2:= $Body/Grnd02
@onready var grnd3:= $Body/Grnd03
@onready var lndseek: RayCast2D = $Body/LandSeek

func _ready() -> void:
	PlayerVars.player = self
	
func _on_enemy_detector_area_entered(area: Area2D) -> void:
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)
	
func _on_enemy_detector_body_entered(body: Node2D) -> void:
	#temporary behavior for the funs	
	velocity = calculate_stomp_velocity(velocity, stomp_impulse)
	#queue_free()


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left") && left <= 0.01:
		left = event.get_action_strength("move_left")
		direction -= left
	elif event.is_action_released("move_left"):
		direction += left
		left = 0.0
	elif event.is_action_pressed("move_right") && right <= 0.01:
		right = event.get_action_strength("move_right")
		direction += right
	elif event.is_action_released("move_right"):
		direction -= right
		right = 0.0	
	
	
	# Handle Jump.
	elif event.is_action_pressed("jump") && !jump:
		jump = true
	elif event.is_action_released("jump"):
		jump = false

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0.0 and sprite.scale.x < 0.0:
		sprite.scale.x *= -1.0
	if direction < 0.0 and sprite.scale.x > 0.0:
		sprite.scale.x *= -1.0
	pass

func physics_process(delta):	
	velocity_logic(delta)
	gravity_logic(delta)
	check_if_shooting()
	collision_logic()
	ground_update_logic(delta)
	
func velocity_logic(delta:float) -> void:
	velocity = velocity.move_toward(Vector2(direction * speed, velocity.y),  acceleration * delta)

func gravity_logic(delta:float) -> void:
#	is_grounded = false
	if is_grounded:
		if is_jumping:              #landed the jump
			jump = false            #force release jump button
			is_jumping = false
#			snap.y = SNAP
		elif jump && down < 0.01:   #works also when re-pressed before ground
			velocity.y = jump_speed
			is_jumping = true
			is_grounded = false
#			snap.y = NO_SNAP
	elif is_onwall:
		if is_jumping:
			jump = false
			is_jumping = false
		elif jump && down < 0.01:
			velocity.y = jump_speed
			is_jumping = true
			is_grounded = false
			is_onwall = false
	else:
		if is_jumping:
			if !jump:               #released jump button mid-air
				is_jumping = false
				if velocity.y < jump_release:
					velocity.y = jump_release
			else:
				velocity.y += gravity * delta
		else:
			velocity.y += gravity * delta
	velocity.y = min(velocity.y, fall_limit)

func collision_logic() -> void:
	move_and_slide()
	
func ground_update_logic(delta: float)->void:
	RayGround_update()
	if is_grounded:
		if !is_on_floor() || !RayGround:          #lost the ground
			is_grounded = false
#			snap.y = NO_SNAP
		if !is_on_wall() || !RayGround:
			is_onwall = false
	else:
		if is_on_wall() && RayGround:
			is_onwall = true
		if !is_on_wall() || !RayGround:
			is_onwall = false
		if is_on_floor() && RayGround:           #just landed
			is_grounded = true
#			jump_count = max_jumps
#			snap.y = SNAP
#			last_wall = 0
	if is_grounded:
#		print_debug(get_floor_angle())
		rotation = lerp(rotation,clamp(-get_floor_angle(),-0.5,0.5), delta * rotate_speed)
	else:
		rotation = lerp(rotation, 0.0, delta * rotate_speed*2)
		pass

func RayGround_update()->void:
	grnd1.force_raycast_update()
	grnd2.force_raycast_update()
	grnd3.force_raycast_update()
	RayGround = grnd1.is_colliding() || grnd2.is_colliding() || grnd3.is_colliding()


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


