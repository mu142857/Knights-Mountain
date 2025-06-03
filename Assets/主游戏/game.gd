extends Node

signal screen_shake(amount: float)
signal screen_flash(amount: float, colour: Color)
signal screen_filter(amount: float, colour: Color)

func _ready() -> void:
	var camera = preload("res://Assets/主角/场景摄像机.tscn").instantiate()
	get_tree().current_scene.add_child(camera)
	
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

func change_scene(scene_path: String, entry_point: String):
	var tree = get_tree()
	
	tree.change_scene_to_file(scene_path)
	await tree.process_frame
	
	for n in tree.get_nodes_in_group("entry_points"):
		if n.name == entry_point:
			tree.current_scene.update_player()
