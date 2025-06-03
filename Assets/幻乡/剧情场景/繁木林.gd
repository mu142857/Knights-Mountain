extends Node2D

func _ready() -> void:
	if Game.player_existed == false:
		var plr = preload("res://Assets/主角/伪战斗主角.tscn").instantiate()
		plr.position = $"主角出生点".global_position
		get_tree().current_scene.add_child(plr)
		Game.player_existed = true
