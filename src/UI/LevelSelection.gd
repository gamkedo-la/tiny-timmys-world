extends Control

@export var garden_level: PackedScene
@export var lab_level: PackedScene
@export var return_to_main_menu: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_garden_pressed():
	get_tree().change_scene_to_packed(garden_level)


func _on_laboratory_pressed():
	get_tree().change_scene_to_packed(lab_level)


func _on_return_pressed():
	get_tree().change_scene_to_packed(return_to_main_menu)
