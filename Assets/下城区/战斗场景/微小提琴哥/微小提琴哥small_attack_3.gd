extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var ready_to_sprint: bool = false

func enter():
	ready_to_sprint = false
	monster.velocity.y = -3000
	ani_2D.play("SmallJumpPrepared") # 开始播放跳跃前准备

func process():
	if ani_2D.animation == "SmallJump":
		
		if monster.velocity.y >= -1500:
			monster.velocity.y = 0
			ani_2D.play("SmallSprint")
			ready_to_sprint = true
			if get_player_info()[1] == -1:
				monster.face_left()
			else:
				monster.face_right()
			return
		monster.velocity.y += 100
		monster.move_and_slide()
		
	if ready_to_sprint:
		sprint()
		$SprintTime.start(0.6)
		ready_to_sprint = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SmallJumpPrepared": # 跳跃前准备播放完后播放跳跃
		ani_2D.play("SmallJump")
	if ani_2D.animation == "SmallAttack3":
		get_parent().change_state(0)

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

func sprint():
	var target_pos: Vector2
	target_pos.x = get_player_info()[2].x
	target_pos.y = 845.997
	var tween = create_tween()

	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.set_trans(Tween.TRANS_QUART)  # 四次缓动曲线
	tween.set_ease(Tween.EASE_IN)       # 加速
	tween.tween_property(monster, "position", target_pos, 0.6) 

func _on_sprint_time_timeout() -> void:
	ani_player.play("SmallAttack3")

func release_effect():
	var expl = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥落地粒子.tscn").instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	Game.shake_camera(17)
	var note = preload("res://Assets/下城区/战斗场景/微小提琴哥/音符粒子.tscn").instantiate()
	note.position = monster.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)
	
func exit():
	ani_player.stop()
