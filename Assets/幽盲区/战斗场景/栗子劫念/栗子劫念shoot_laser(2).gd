extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

@onready var beam1: RayCast2D = $"../../栗子激光1"
@onready var aim_line1: RayCast2D = $"../../栗子激光瞄准线1"
@onready var beam2: RayCast2D = $"../../栗子激光2"
@onready var aim_line2: RayCast2D = $"../../栗子激光瞄准线2"
@onready var beam3: RayCast2D = $"../../栗子激光3"
@onready var aim_line3: RayCast2D = $"../../栗子激光瞄准线3"
@onready var beam4: RayCast2D = $"../../栗子激光4"
@onready var aim_line4: RayCast2D = $"../../栗子激光瞄准线4"
@onready var beam5: RayCast2D = $"../../栗子激光5"
@onready var aim_line5: RayCast2D = $"../../栗子激光瞄准线5"

var player_position: Vector2
var beam_target_position1: Vector2
var beam_target_position2: Vector2
var beam_target_position3: Vector2
var beam_target_position4: Vector2
var beam_target_position5: Vector2

func enter():
	$Timer.start(1.4)
	ani_player.play("laser")

	if get_player_info()[1] == 1:
		monster.face_left()
	else:
		monster.face_right()

	ani_2D.modulate = Color(1, 1, 1)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(ani_2D, "modulate", Color(1.6, 1.6, 1.6), 0.3)

func exit():
	ani_player.stop()

func get_player_direction() -> Vector2:
	var position: Vector2 = Vector2.ZERO
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				position = i.global_position
	return position

func aim1(): 
	player_position = get_player_direction()
	calculate_target_position1(player_position + Vector2(0, 50))
	aim_line1.target_position = aim_line1.to_local(beam_target_position1)
	beam1.target_position = beam1.to_local(beam_target_position1)

func attack1():
	Game.shake_camera(10)
	beam1.force_raycast_update()
	beam1.cast_beem()

func calculate_target_position1(pos: Vector2):
	var diff: Vector2 = pos - aim_line1.global_position
	var diff_sign: float = pos.x - aim_line1.global_position.x
	var mul = 1400 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position1 = aim_line1.global_position + diff

func preattack1():
	aim_line1.force_raycast_update()
	aim_line1.cast_beem()

#2
func aim2(): 
	player_position = get_player_direction()
	calculate_target_position2(player_position + Vector2(0, -100))
	aim_line2.target_position = aim_line2.to_local(beam_target_position2)
	beam2.target_position = beam2.to_local(beam_target_position2)

func attack2():
	beam2.force_raycast_update()
	beam2.cast_beem()

func calculate_target_position2(pos: Vector2):
	var diff: Vector2 = pos - aim_line2.global_position
	var diff_sign: float = pos.x - aim_line2.global_position.x
	var mul = 1400 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position2 = aim_line2.global_position + diff

func preattack2():
	aim_line2.force_raycast_update()
	aim_line2.cast_beem()

#3
func aim3(): 
	player_position = get_player_direction()
	calculate_target_position3(player_position + Vector2(0, -275))
	aim_line3.target_position = aim_line3.to_local(beam_target_position3)
	beam3.target_position = beam3.to_local(beam_target_position3)

func attack3():
	Game.shake_camera(10)
	beam3.force_raycast_update()
	beam3.cast_beem()

func calculate_target_position3(pos: Vector2):
	var diff: Vector2 = pos - aim_line3.global_position
	var diff_sign: float = pos.x - aim_line3.global_position.x
	var mul = 1400 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position3 = aim_line3.global_position + diff

func preattack3():
	aim_line3.force_raycast_update()
	aim_line3.cast_beem()

#4
func aim4(): 
	player_position = get_player_direction()
	calculate_target_position4(player_position + Vector2(0, -450))
	aim_line4.target_position = aim_line4.to_local(beam_target_position4)
	beam4.target_position = beam4.to_local(beam_target_position4)

func attack4():
	#Game.flash(9, Color(0.9, 0.8, 1, 0.3))
	#Game.shake_camera(18)
	beam4.force_raycast_update()
	beam4.cast_beem()

func calculate_target_position4(pos: Vector2):
	var diff: Vector2 = pos - aim_line4.global_position
	var diff_sign: float = pos.x - aim_line4.global_position.x
	var mul = 1400 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position4 = aim_line4.global_position + diff

func preattack4():
	aim_line4.force_raycast_update()
	aim_line4.cast_beem()

#5
func aim5(): 
	player_position = get_player_direction()
	calculate_target_position5(player_position + Vector2(0, -625))
	aim_line5.target_position = aim_line5.to_local(beam_target_position5)
	beam5.target_position = beam5.to_local(beam_target_position5)

func attack5():
	Game.flash(9, Color(0.9, 0.8, 1, 0.3))
	Game.shake_camera(18)
	beam5.force_raycast_update()
	beam5.cast_beem()

func calculate_target_position5(pos: Vector2):
	var diff: Vector2 = pos - aim_line5.global_position
	var diff_sign: float = pos.x - aim_line5.global_position.x
	var mul = 1400 / diff.x
	if diff_sign < 0:
		diff *= -mul
	else:
		diff *= mul
	beam_target_position5 = aim_line5.global_position + diff

func preattack5():
	aim_line5.force_raycast_update()
	aim_line5.cast_beem()

func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	$"../Idle(0)/ChangeStateTimer".start(0.3)
	tween.parallel().tween_property(ani_2D, "modulate", Color(1, 1, 1), 0.3)
	
func _on_change_state_timer_timeout() -> void:
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
