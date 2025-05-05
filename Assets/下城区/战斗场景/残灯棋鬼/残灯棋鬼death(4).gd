extends Basic_State

@onready var checkerboard_left: CharacterBody2D = $"../../残灯移动棋盘/残灯移动棋盘左"
@onready var checkerboard_right: CharacterBody2D = $"../../残灯移动棋盘/残灯移动棋盘右"

func enter():
	stop_timer()
	$Timer.start(4)
	$"../..".modulate.a = 0
	
	checkerboard_left.transition(0)
	checkerboard_right.transition(0)

	Game.shake_camera(40)
	var expl = preload("res://Assets/下城区/战斗场景/残灯棋鬼/死亡粒子.tscn").instantiate()
	expl.position = $"../..".global_position + Vector2(0, -150)
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	$"../..".global_position.y = 0

func _on_timer_timeout() -> void:
	self.queue_free()

func stop_timer():
	$"../Idle(0)/Timer".stop()
	$"../Disappear(1)/HidenTimer".stop()
	$"../Summon(3)/InSkillDuration".stop()
	$"../Summon(3)/AfterSummonDuration".stop()
