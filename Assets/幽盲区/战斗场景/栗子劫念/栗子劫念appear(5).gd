extends  Basic_State
@onready var monster: CharacterBody2D = $"../.."
@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var shuij = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子掉落水晶.tscn")

func enter():
	$Timer.start(0.4)
	var sj1 = shuij.instantiate()
	var sj2 = shuij.instantiate()
	sj1.position = Vector2(randf_range(100, 600), 0)
	sj2.position = Vector2(randf_range(800, 1300), 0)
	get_tree().current_scene.add_child(sj1)
	get_tree().current_scene.add_child(sj2)

func process():
	pass

func exit():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Appear":
		get_parent().change_state(0)


func _on_timer_timeout() -> void:
	monster.set_collision_layer_value(4, true)
	ani_2D.play("Appear")
	if get_player_info()[1] == 1:
		monster.face_left()
	else:
		monster.face_right()
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(ani_2D, "modulate", Color(1, 1, 1), 0.8)

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
