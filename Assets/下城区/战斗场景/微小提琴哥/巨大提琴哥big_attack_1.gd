extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

@onready var beam: RayCast2D = $"../../提琴哥激光"
@onready var aim_line: RayCast2D = $"../../提琴哥激光瞄准线"

var player_position: Vector2
var beam_target_position: Vector2

func enter():
	ani_player.play("BigAttack1")
	beam_target_position = Vector2.ZERO
	player_position = Vector2.ZERO
	
func exit():
	ani_player.stop()

func aim(): 
	player_position = get_player_direction()
	calculate_target_position(player_position)
	aim_line.target_position = aim_line.to_local(beam_target_position)
	beam.target_position = beam.to_local(beam_target_position)
	#aim_line.target_position = aim_line.to_local(player_position)
	#beam.target_position = beam.to_local(player_position)

func attack():
	Game.flash(2, Color(0.8, 0.8, 1))
	Game.shake_camera(4)
	beam.force_raycast_update()
	beam.cast_beem()

func get_player_direction() -> Vector2:
	var position: Vector2 = Vector2.ZERO
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				position = i.global_position
	return position

func calculate_target_position(pos: Vector2):
	var diff: Vector2 = pos - aim_line.global_position
	var diff_sign: float = pos.x - aim_line.global_position.x
	var mul = 1400 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position = aim_line.global_position + diff

func preattack():
	aim_line.force_raycast_update()
	aim_line.cast_beem()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "BigAttack1":
		get_parent().change_state(8)

func release_barrage(): # 召唤飞弹(deifan)弹幕
	var deifan4 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn").instantiate()
	var deifan5 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn").instantiate()
	var deifan6 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn").instantiate()
	var deifan7 = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴哥飞弹.tscn").instantiate()
	deifan4.position = $"../../AttackCheck/激光发射点".global_position
	deifan5.position = $"../../AttackCheck/激光发射点".global_position
	deifan6.position = $"../../AttackCheck/激光发射点".global_position
	deifan7.position = $"../../AttackCheck/激光发射点".global_position
	deifan4.modulate = Color(0.6, 1, 0.6)
	deifan5.modulate = Color(0.6, 0.6, 1)
	deifan6.modulate = Color(1, 1, 0.6)
	deifan7.modulate = Color(1, 0.6, 0.6)
	deifan4.barrage_position = 4
	deifan5.barrage_position = 5
	deifan6.barrage_position = 6
	deifan7.barrage_position = 7
	get_tree().current_scene.add_child(deifan4)
	get_tree().current_scene.add_child(deifan5)
	get_tree().current_scene.add_child(deifan6)
	get_tree().current_scene.add_child(deifan7)
