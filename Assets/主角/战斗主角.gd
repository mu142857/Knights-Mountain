class_name Player
extends CharacterBody2D

func _ready() -> void:
	self.add_to_group("player")
	#$ShadowCreater.start(1)

func _on_shadow_creater_timeout() -> void:
	var player_shadow = preload("res://Assets/主角/角色阴影.tscn").instantiate()
	player_shadow.global_position = self.global_position
	get_parent().add_child(player_shadow)
	var cam = preload("res://Assets/主角/场景摄像机.tscn").instantiate()
	get_parent().add_child(cam)
	
