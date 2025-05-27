extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var tiqingefeidan1 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn")
var tiqingefeidan2 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn")
var tiqingefeidan3 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn")

func enter():
	ani_player.play("SmallAttack2")
	
	if get_player_info()[1] == -1:
		monster.face_left()
	else:
		monster.face_right()
	
func exit():
	ani_player.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SmallAttack2":
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

func release_barrage(): # 召唤飞弹(deifan)弹幕
	var deifan1 = tiqingefeidan1.instantiate()
	var deifan2 = tiqingefeidan2.instantiate()
	var deifan3 = tiqingefeidan3.instantiate()
	deifan1.position = monster.global_position + Vector2(0, -60)
	deifan2.position = monster.global_position + Vector2(0, -60)
	deifan3.position = monster.global_position + Vector2(0, -60)
	deifan1.modulate = Color(1, 0.6, 0.6)
	deifan2.modulate = Color(0.6, 1, 0.6)
	deifan3.modulate = Color(0.6, 0.6, 1)
	deifan1.barrage_position = 1
	deifan2.barrage_position = 2
	deifan3.barrage_position = 3
	get_tree().current_scene.add_child(deifan1)
	get_tree().current_scene.add_child(deifan2)
	get_tree().current_scene.add_child(deifan3)
