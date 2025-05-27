extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var feidan = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn")


func enter():
	ani_player.play("BigAttack3")
	
	if get_player_info()[1] == -1:
		monster.face_left()
	else:
		monster.face_right()

func process():
	pass

func exit():
	ani_player.stop()

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


func release_feidan(): # 召唤飞弹(deifan)弹幕
	var deifan8 = feidan.instantiate()
	var deifan9 = feidan.instantiate()
	var deifan10 = feidan.instantiate()
	var deifan11 = feidan.instantiate()
	var deifan12 = feidan.instantiate()
	var deifan13 = feidan.instantiate()
	var deifan14 = feidan.instantiate()
	deifan8.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan9.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan10.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan11.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan12.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan13.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan14.position = $"../../AttackCheck/弹幕发射点".global_position
	deifan8.modulate = Color(1, 0.5, 0.5)
	deifan9.modulate = Color(1, 0.75, 0.5)
	deifan10.modulate = Color(1, 1, 0.5)
	deifan11.modulate = Color(0.5, 1, 0.5)
	deifan12.modulate = Color(0.5, 1, 1)
	deifan13.modulate = Color(0.5, 0.5, 1)
	deifan14.modulate = Color(0.75, 0.5, 1)
	deifan8.barrage_position = 8
	deifan9.barrage_position = 9
	deifan10.barrage_position = 10
	deifan11.barrage_position = 11
	deifan12.barrage_position = 12
	deifan13.barrage_position = 13
	deifan14.barrage_position = 14
	get_tree().current_scene.add_child(deifan8)
	get_tree().current_scene.add_child(deifan9)
	get_tree().current_scene.add_child(deifan10)
	get_tree().current_scene.add_child(deifan11)
	get_tree().current_scene.add_child(deifan12)
	get_tree().current_scene.add_child(deifan13)
	get_tree().current_scene.add_child(deifan14)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "BigAttack3":
		get_parent().change_state(8)
