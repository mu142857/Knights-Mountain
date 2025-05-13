extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Fall")
	monster.velocity.x = $"../Jump(2)".x_addi * $"../Jump(2)".jump_direction

func process():
	if monster.is_on_floor() or monster.global_position.y >= 840:
		get_parent().change_state(1)
		return
		
	monster.velocity.y += 30
	monster.move_and_slide()

func exit():
	attack_check()
	Game.shake_camera(8)
	var expl = preload("res://Assets/下城区/战斗场景/残灯兵/跳跃落地粒子.tscn").instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)

# 受击反弹函数
func take_hit():
	var dir = get_player_direction()[1]
	
	monster.position.x -= 10 * dir
	monster.position.y += 10
	monster.move_and_slide()
	
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
			i.take_hit(20)
