extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var backline: Line2D = $"../../Node/Line2D"

var left_or_right: int = 0

func enter():
	backline.show()
	ani_2D.play("SmallDisappear")
	backline.is_spawn = false
	backline.modulate.a = 1
	
func process():
	if ani_2D.animation == "SmallDisappear":
		pass
	
func get_player_info() -> Array:
	var direction: int = 0
	var distance: float = 0.0
	var position: Vector2 = Vector2.ZERO
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				direction = sign(i.global_position.x - monster.global_position.x)
				distance = abs(i.global_position.x - monster.global_position.x)
				position = i.global_position
	return [distance, direction, position] # direction中，-1表示(在主角)左边，1表示右边，0表示未知

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SmallDisappear":
		ani_2D.play("SmallMove")
		$TransitionTimer.start(0.5)
		if get_player_info()[1] == -1:
			monster.face_left()
		else:
			monster.face_right()
		backline.is_spawn = true
		$SecondSprintTimer.start(0.3)
		trantition_one()

func trantition_one():
	var position_x_list = [50, -50]
	var rand_num = position_x_list[randi_range(0, 1)]
	left_or_right = rand_num
	var target_pos: Vector2
	target_pos.x = get_player_info()[2].x + rand_num
	
	if target_pos.x > 1380:
		target_pos.x = 1380
	elif target_pos.x < 20:
		target_pos.x = 20
		
	target_pos.y = 845.997
	var tween = create_tween()

	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.set_trans(Tween.TRANS_QUART)       # 二次缓动曲线（加速—减速）
	tween.set_ease(Tween.EASE_IN_OUT)       # 先加速后减速
	tween.tween_property(monster, "position", target_pos, 0.3) 

func trantition_two():

	var target_pos: Vector2
	target_pos.x = get_player_info()[2].x + (left_or_right * -7)
	
	if target_pos.x > 1380:
		target_pos.x = 1380
	elif target_pos.x < 20:
		target_pos.x = 20
		
	target_pos.y = 845.997
	var tween = create_tween()

	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.set_trans(Tween.TRANS_QUART)       # 二次缓动曲线（加速—减速）
	tween.set_ease(Tween.EASE_IN_OUT)       # 先加速后减速
	tween.tween_property(monster, "position", target_pos, 0.2) 

func _on_transition_timer_timeout() -> void:
	if get_player_info()[1] == -1:
		monster.face_left()
	else:
		monster.face_right()
	get_parent().change_state(5)
	var note = preload("res://Assets/下城区/战斗场景/微小提琴哥/小型音符粒子.tscn").instantiate()
	note.position = monster.global_position + Vector2(0, -75)
	note.emitting = true
	get_tree().current_scene.add_child(note)
	trantition_two()

func exit():
	$TransitionTimer.stop()
	$SecondSprintTimer.stop()

func _on_second_sprint_timer_timeout() -> void:
	var note = preload("res://Assets/下城区/战斗场景/微小提琴哥/小型音符粒子.tscn").instantiate()
	note.position = monster.global_position + Vector2(0, -75)
	note.emitting = true
	get_tree().current_scene.add_child(note)
	trantition_two()
