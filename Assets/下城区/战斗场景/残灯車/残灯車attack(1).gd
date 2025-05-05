extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var is_jumping: bool = true
var is_falling: bool = false
		
func enter():
	$"../Move(3)/Timer".stop()
	is_jumping = true
	is_falling = false
	monster.velocity.y = -2700
	monster.velocity.x = 0

func process():
	
	if !is_jumping:
		if monster.is_on_floor() or monster.global_position.y >= 840:
			get_parent().change_state(0)
			return
	if monster.velocity.y >= 0 and !is_falling:
		is_jumping = false
		is_falling = true
		var expl_a = preload("res://Assets/下城区/战斗场景/残灯車/空中散布粒子.tscn").instantiate()
		expl_a.global_position = monster.global_position
		expl_a.emitting = true
		get_tree().current_scene.add_child(expl_a)

	
	monster.velocity.y += 100
	monster.move_and_slide()

func exit():
	is_falling = false
	Game.shake_camera(30)
	
	var expl_b = preload("res://Assets/下城区/战斗场景/残灯車/跳跃落地粒子.tscn").instantiate()
	expl_b.global_position = monster.global_position
	expl_b.emitting = true
	get_tree().current_scene.add_child(expl_b)
