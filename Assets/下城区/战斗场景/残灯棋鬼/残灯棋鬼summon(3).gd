extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster: CharacterBody2D = $"../.."

# 初始化：为每个 health_level 设置初始召唤索引 0
var summon_index_by_level = {0: 0, 1: 0, 2: 0, 3: 0}

func enter():
	
	ani_player.play("Summon")

func enter_branch():
	# 获取当前Boss阶段
	var level = int(monster.health_level)
	# 当前阶段对应的召唤步骤索引
	var idx = int(summon_index_by_level[level])
	# 下一个步骤索引
	var next_idx = 0

	match level:
		# 第0阶段
		0:
			match idx:
				0:	
					summon_monster("pawn", "left")
					next_idx = 1
				1:
					summon_monster("pawn", "right")
					next_idx = 2
				2:
					summon_monster("knight", "left")
					next_idx = 3
				3:
					summon_monster("knight", "right")
					next_idx = 4
				4:
					summon_monster("pawn", "left")
					summon_monster("pawn", "right")
					next_idx = 5
				5:
					summon_monster("pawn", "left")
					summon_monster("knight", "right")
					next_idx = 6
				6:
					summon_monster("knight", "left")
					summon_monster("pawn", "right")
					next_idx = 7
				7:
					summon_monster("knight", "left")
					summon_monster("knight", "right")
					# 循环回第5步
					next_idx = 4

		# 第1阶段
		1:
			match idx:
				0:
					summon_monster("bishop", "middle")
					next_idx = 1
				1:
					summon_monster("bishop", "left")
					summon_monster("bishop", "right")
					next_idx = 2
				2:
					if randi() % 2 == 0:
						summon_monster("knight", "left")
						summon_monster("bishop", "right")
					else:
						summon_monster("knight", "right")
						summon_monster("bishop", "left")
					next_idx = 3
				3:
					summon_monster("pawn", "left")
					summon_monster("pawn", "right")
					next_idx = 4
				4:
					var choice = randi() % 3
					if choice == 0:
						summon_monster("pawn", "left")
						summon_monster("knight", "right")
					elif choice == 1:
						summon_monster("knight", "left")
						summon_monster("pawn", "right")
					else:
						summon_monster("knight", "left")
						summon_monster("knight", "right")
					# 循环回第2步
					next_idx = 1

		# 第2阶段
		2:
			match idx:
				0:
					summon_monster("rook", "middle")
					next_idx = 1
				1:
					# 先召唤中间bishop
					summon_monster("bishop", "middle")
					# 延迟2秒后召唤左pawn
					await get_tree().create_timer(2.0).timeout
					summon_monster("pawn", "left")
					# 再延迟2秒后召唤右pawn
					await get_tree().create_timer(2.0).timeout
					summon_monster("pawn", "right")
					next_idx = 2
				2:
					# 先召唤中间bishop
					summon_monster("bishop", "middle")
					# 延迟2秒后召唤左或右knight
					await get_tree().create_timer(2.0).timeout
					if randi() % 2 == 0:
						summon_monster("knight", "left")
					else:
						summon_monster("knight", "right")
					# 循环回第1步
					next_idx = 0

		# 第3阶段
		3:
			match idx:
				0:
					# 先召唤左或右knight，再延迟2秒召唤另一个方向的rook
					if randi() % 2 == 0:
						summon_monster("knight", "left")
						await get_tree().create_timer(2.0).timeout
						summon_monster("rook", "right")
					else:
						summon_monster("knight", "right")
						await get_tree().create_timer(2.0).timeout
						summon_monster("rook", "left")
					next_idx = 1
				1:
					# 先召唤左或右bishop，再延迟2秒召唤另一个方向的rook
					if randi() % 2 == 0:
						summon_monster("bishop", "left")
						await get_tree().create_timer(2.0).timeout
						summon_monster("rook", "right")
					else:
						summon_monster("bishop", "right")
						await get_tree().create_timer(2.0).timeout
						summon_monster("rook", "left")
					next_idx = 2
				2:
					summon_monster("pawn", "left")
					summon_monster("pawn", "right")
					# 循环回第1步
					next_idx = 0

	# 更新当前阶段的下一个索引
	summon_index_by_level[level] = next_idx

	# 召唤完成后，Boss进入消失状态（由 AfterSummonDuration 控制切出）
	# 后续召唤逻辑将在 InSkillDuration 定时后由再次进入该状态时触发。

func process():
	pass

func exit():
	ani_player.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	ani_2D.play("Idle")
	$AfterSummonDuration.start(1)

func _on_after_summon_duration_timeout() -> void:
	get_parent().change_state(1)

func release_hit_effect():
	Game.shake_camera(25)
	var expl = preload("res://Assets/下城区/战斗场景/残灯棋鬼/砸地粒子.tscn").instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)

func summon_monster(type: String, summon_position: String):
	var pre_summon = preload("res://Assets/下城区/战斗场景/残灯棋鬼/天上掉怪粒子.tscn").instantiate()
	# 决定召唤类型
	var piece
	if type == "pawn":
		piece = preload("res://Assets/下城区/战斗场景/残灯兵/残灯兵.tscn").instantiate()
	elif type == "knight":
		piece = preload("res://Assets/下城区/战斗场景/残灯马/残灯马.tscn").instantiate()
	elif type == "rook":
		piece = preload("res://Assets/下城区/战斗场景/残灯車/残灯車.tscn").instantiate()
	elif type == "bishop":
		piece = preload("res://Assets/下城区/战斗场景/残灯主教/残灯主教.tscn").instantiate()
	else:
		return
		
	piece.scene_startx = monster.scene_startx
	piece.scene_endx = monster.scene_endx
	
	#决定召唤位置
	if summon_position == "left":
		piece.position = Vector2(monster.scene_startx + 200, 0)
		piece.direct = Vector2.RIGHT
		pre_summon.position = Vector2(monster.scene_startx + 200, 0)
	elif summon_position == "right":
		piece.position = Vector2(monster.scene_endx - 200, 0)
		piece.direct = Vector2.LEFT
		pre_summon.position = Vector2(monster.scene_endx - 200, 0)
	elif summon_position == "middle":
		piece.position = Vector2((monster.scene_startx + monster.scene_endx) / 2, 0)
		pre_summon.position = Vector2((monster.scene_startx + monster.scene_endx) / 2, 0)
	pre_summon.emitting = true
	get_tree().current_scene.add_child(pre_summon)
	await get_tree().create_timer(2).timeout
	get_tree().current_scene.add_child(piece)
