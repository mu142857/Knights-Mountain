extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	ani_player.play("SmallAttack1")
	
	if get_player_info()[1] == -1:
		monster.face_left()
	else:
		monster.face_right()

func exit():
	ani_player.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SmallAttack1":
		get_parent().change_state(0)

func release_effect():
	Game.shake_camera(10)
	var expl = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴拍地粒子.tscn").instantiate()
	expl.position = $"../../AttackCheck/SmallAttack1".global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	var note = preload("res://Assets/下城区/战斗场景/微小提琴哥/音符粒子.tscn").instantiate()
	note.position = $"../../AttackCheck/SmallAttack1".global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)
	release_wave()

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

func release_wave():
	var wave = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴波发射器.tscn").instantiate()
	wave.direct = monster.direct
	wave.position = $"../../AttackCheck/SmallAttack1".global_position
	wave.small_or_big = "small"
	get_tree().current_scene.add_child(wave)
