extends Control
var item_list: ItemList
# Called when the node enters the scene tree for the first time.
func _ready():
	item_list = get_node("Panel/Panel/ItemList")
	if PlayerVars.high_scores.size() == 0:
		item_list.add_item(" No Scores Yet...")
	else:
		item_list.add_item("Rank          Score", null, false)
		var index = 0
		for i in PlayerVars.high_scores:
			item_list.add_item("  %d                 %d" % [index, i] , null, false)
			index = index + 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_pressed():
	get_tree().change_scene_to_file("res://src/UI/MainMenu.tscn")
