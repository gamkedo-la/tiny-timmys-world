extends CharacterBody2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@export var SPEED: float = 1000.0
@export var direction: Vector2 = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.x = direction.x * SPEED
	velocity.y = direction.y * SPEED

	move_and_slide()


func _on_collision_detector_area_entered(area: Area2D) -> void:
	if(audio_stream_player.playing):
		audio_stream_player.stop()
	queue_free()


func _on_collision_detector_body_entered(body: Node2D) -> void:
	if(audio_stream_player.playing):
		audio_stream_player.stop()
	queue_free()
