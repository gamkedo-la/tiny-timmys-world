extends Control

@export var garden_level: PackedScene
@export var lab_level: PackedScene
@export var return_to_main_menu: PackedScene

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_garden_pressed():
	queue_free()
	get_tree().change_scene_to_packed(garden_level)


func _on_laboratory_pressed():
	queue_free()
	get_tree().change_scene_to_packed(lab_level)


func _on_return_pressed():
	get_tree().change_scene_to_file("res://src/UI/MainMenu.tscn")
