extends Node

signal screen_shake(amount: float, colour: Color)
signal screen_flash(amount: float)

func _ready() -> void:
	var camera = preload("res://Assets/主角/场景摄像机.tscn").instantiate()
	get_tree().current_scene.add_child(camera)
	
func shake_camera(amount: float): # 震屏
	screen_shake.emit(amount)
	
func flash(amount: float, colour: Color): # 闪屏
	screen_flash.emit(amount, colour)
	
func frame_freeze(timescale, duration): # 静止帧
	Engine.time_scale = timescale
	await get_tree().create_timer(duration, true, false, true).timeout
	Engine.time_scale = 1.0
	pass
