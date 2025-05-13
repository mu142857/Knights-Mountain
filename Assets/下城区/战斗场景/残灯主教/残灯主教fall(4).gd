extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	monster.velocity.x = -200 * $"../Jump(3)".jump_direction * $"../Jump(3)".jump_random

func process():
	if monster.is_on_floor() or monster.global_position.y >= 840:
		get_parent().change_state(1)
		return
		
	monster.velocity.y += 30
	monster.move_and_slide()

func exit():
	
	attack_check()
	
	ani_2D.scale.x = get_player_direction()[1] * -3
	
	Game.shake_camera(10)
	var expl = preload("res://Assets/下城区/战斗场景/残灯主教/主教跳跃落地粒子.tscn").instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	
func get_player_direction() -> Array:
	var direction: int = 0
	var distance = 0.0
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				direction = sign(i.global_position.x - monster.global_position.x)
				distance = abs(i.global_position.x - monster.global_position.x)
	return [distance, direction] # direction中，-1表示左边，1表示右边，0表示未知

func attack_check():
	var arr = $"../../AttackCheck".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(30)
