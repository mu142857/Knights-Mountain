extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	ani_player.play("Attack")
	
	if get_player_info()[1] == -1:
		monster.face_left()
	else:
		monster.face_right()

func exit():
	ani_player.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Attack":
		get_parent().change_state(0)

func release_effect():

	Game.shake_camera(10)

	var note = preload("res://Assets/下城区/战斗场景/微小提琴哥/音符粒子.tscn").instantiate()
	note.position = $"../../AttackCheck/Attack3".global_position
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
	wave.position = $"../../AttackCheck/Attack3".global_position
	wave.small_or_big = "small"
	get_tree().current_scene.add_child(wave)

func attack1_check():
	var arr = $"../../AttackCheck/Attack1".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(20)

func attack2_check():
	var arr = $"../../AttackCheck/Attack2".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(20)

func attack3_check():
	var arr = $"../../AttackCheck/Attack3".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(20)

func release_barrage(): # 召唤飞弹(deifan)弹幕
	var deifan0 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	var deifan1 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	var deifan2 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	var deifan3 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	deifan0.position = monster.global_position + Vector2(0, -50)
	deifan1.position = monster.global_position + Vector2(0, -50)
	deifan2.position = monster.global_position + Vector2(0, -50)
	deifan3.position = monster.global_position + Vector2(0, -50)
	deifan0.modulate = Color(0.6, 1, 1)
	deifan1.modulate = Color(0.6, 1, 0.6)
	deifan2.modulate = Color(0.6, 0.6, 1)
	deifan3.modulate = Color(0.6, 1, 1)
	deifan0.barrage_position = 0
	deifan1.barrage_position = 1
	deifan2.barrage_position = 2
	deifan3.barrage_position = 3
	get_tree().current_scene.add_child(deifan0)
	get_tree().current_scene.add_child(deifan1)
	get_tree().current_scene.add_child(deifan2)
	get_tree().current_scene.add_child(deifan3)

func drop_barrage():
	var player_x = get_player_info()[2].x
	var deifan4 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	var deifan5 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	var deifan6 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	var deifan7 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	deifan4.position = Vector2(player_x + 450, 0)
	deifan5.position = Vector2(player_x + 150, 0)
	deifan6.position = Vector2(player_x - 150, 0)
	deifan7.position = Vector2(player_x - 450, 0)
	deifan4.modulate = Color(1, 0.6, 0.6)
	deifan5.modulate = Color(1, 0.8, 0.6)
	deifan6.modulate = Color(1, 1, 0.6)
	deifan7.modulate = Color(1, 0.8, 0.6)
	deifan4.barrage_position = 4
	deifan5.barrage_position = 5
	deifan6.barrage_position = 6
	deifan7.barrage_position = 7
	get_tree().current_scene.add_child(deifan4)
	get_tree().current_scene.add_child(deifan5)
	get_tree().current_scene.add_child(deifan6)
	get_tree().current_scene.add_child(deifan7)
