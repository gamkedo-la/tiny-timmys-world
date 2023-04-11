extends AIActor

@onready var _animated_sprite = $AnimatedSprite2D
@onready var tongue_base: Node2D = $Tongue
@onready var tongue_line: Line2D = $Tongue/TongueLine
@onready var tongue_tip: Area2D = $Tongue/TongueTip

func _ready():
	tongue_base.visible = false
	pass


func physics_process(delta: float) -> void:
	
	move_and_slide()
	pass

func ani_player_play(anim: String) -> void:
	_animated_sprite.play(anim)

func fire_tongue(pos: Vector2) -> void:
	tongue_base.visible = true
	var tongue_tween = create_tween()
	var loc_pos = tongue_line.to_local(pos)
	tongue_line.clear_points()
	tongue_line.add_point(Vector2(0,0), 0)
	tongue_line.add_point(Vector2(0,0), 1)
	tongue_tip.monitoring = true
#	print_debug("Player Pos: ", PlayerVars.player.global_position)
#	print_debug("Tongue target local: ", loc_pos)
#	print_debug("Tongue target global: ", pos)
	tongue_tween.tween_method(update_tongue, tongue_line.points[1], loc_pos, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	tongue_tween.tween_property(tongue_tip, "global_position", pos, 0.3).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_IN)
	

func update_tongue(new_pos: Vector2):
	tongue_line.set_point_position(1, new_pos)

func retract_tongue() -> void:
	var tongue_tween = create_tween()
	tongue_tip.monitoring = false
	tongue_tween.tween_method(update_tongue, tongue_line.points[1], Vector2.ZERO, 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tongue_tween.tween_property(tongue_tip, "position", Vector2.ZERO, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tongue_tween.chain().tween_callback(hide_tongue)

func hide_tongue() -> void:
	
	tongue_base.visible = false
