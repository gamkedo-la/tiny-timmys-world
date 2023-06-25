extends Control

@export var garden_level: PackedScene
@export var lab_level: PackedScene
@export var return_to_main_menu: PackedScene
@onready var parallax = $ParallaxBackground
var parallax_bg_velocity = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	parallax.scroll_base_offset.x -= parallax_bg_velocity

func _on_garden_pressed():
	queue_free()
	get_tree().change_scene_to_packed(garden_level)


func _on_laboratory_pressed():
	queue_free()
	get_tree().change_scene_to_packed(lab_level)


func _on_return_pressed():
	get_tree().change_scene_to_file("res://src/UI/MainMenu.tscn")
