extends Node

signal screen_shake(amount: float)
signal screen_flash(amount: float, colour: Color)
signal screen_filter(amount: float, colour: Color)

@onready var colour_rect: ColorRect = $CanvasLayer/ColorRect

var zdzj = preload("res://Assets/主角/战斗主角.tscn")
var wzdzj = preload("res://Assets/主角/伪战斗主角.tscn")
#var xiangji = preload("res://Assets/主角/场景摄像机.tscn")

var player_existed: bool = false

func _ready() -> void:
	player_existed = false
	colour_rect.color.a = 0
	
func shake_camera(amount: float): # 震屏
	screen_shake.emit(amount)
	
func flash(amount: float, colour: Color): # 闪屏
	screen_flash.emit(amount, colour)

func filter(amount: float, colour: Color): # 闪屏
	screen_filter.emit(amount, colour)

func frame_freeze(timescale, duration): # 静止帧
	Engine.time_scale = timescale
	$"提琴哥圣曲".pitch_scale = timescale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
	$"提琴哥圣曲".pitch_scale = 1.0

func play_music_tiqingeshengqu():
	$"提琴哥圣曲".play()

func change_pos(body: CharacterBody2D, entry_point: String):
	var tree = get_tree()
	var tween = create_tween()
	tween.tween_property(colour_rect, "color:a", 1, 0.03)
	await tween.finished
	await get_tree().create_timer(0.3).timeout
	
	for n in tree.get_nodes_in_group("entry_points"):
		if n.name == entry_point:
			body.global_position = n.global_position
	
	tween = create_tween()
	tween.tween_property(colour_rect, "color:a", 0, 0.37)
	
func change_scene(scene_path: String, entry_point: String, player_battle: bool):
	var tree = get_tree()
	var tween = create_tween()
	tween.tween_property(colour_rect, "color:a", 1, 0.03)
	await tween.finished
	
	tree.change_scene_to_file(scene_path)
	await tree.process_frame
	await get_tree().create_timer(0.3).timeout
	
	for n in tree.get_nodes_in_group("entry_points"):
		if n.name == entry_point:
			var player
			if player_battle:
				player = zdzj.instantiate()
				var camera = preload("res://Assets/主角/场景摄像机.tscn").instantiate()
				get_tree().current_scene.add_child(camera)
			else:
				player = wzdzj.instantiate()
			player.global_position = n.global_position
			tree.current_scene.add_child(player)
	
	tween = create_tween()
	tween.tween_property(colour_rect, "color:a", 0, 0.37)
