extends Basic_State #4

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var ready_to_dive: bool = false
var target_position_shift: Array = [0, 100, -100, 200, -200]

var luodilizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑落地粒子.tscn")
var yinfulizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")
var fd = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑十字炸弹.tscn")

var dive_times: int = 3 # 冲刺班次数

func enter():
	dive_times = 3
	ready_to_dive = false
	monster.velocity.y = -500
	ani_2D.play("Jump") # 开始播放跳跃前准备

func process():
	if ani_2D.animation == "Jump":
		
		if monster.velocity.y >= 0:
			monster.velocity.y = 0
			ani_2D.play("Dive")
			ready_to_dive = true
		
			var shift = target_position_shift[randi() % target_position_shift.size()]
			shift += get_player_info()[2].x
			monster.global_position.x = shift # 设置移到玩家头顶位置

			#if get_player_info()[1] == -1:
			#	monster.face_left()
			#else:
			#	monster.face_right()
			#return
		monster.velocity.y += 10
		monster.move_and_slide()
		
	if ready_to_dive:
		sprint()
		$DiveTime.start(0.5)
		ready_to_dive = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Dive":
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

func sprint():
	var target_pos: Vector2
	target_pos.x = monster.global_position.x
	target_pos.y = 845.997
	
	var tween = create_tween()
	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.set_trans(Tween.TRANS_QUART)  # 四次缓动曲线
	tween.set_ease(Tween.EASE_IN)       # 加速
	tween.tween_property(monster, "position", target_pos, 0.5) 

func release_effect():
	
	#attack_check()
	
	var expl = luodilizi.instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	Game.shake_camera(20)
	var note = yinfulizi.instantiate()
	note.position = monster.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)
	
func exit():
	$DiveTime.stop()

func attack_check():
	var arr = $"../../AttackCheck/冲撞".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(30)

func _on_dive_time_timeout() -> void:
	attack_check()
	release_effect()
	#print(dive_times)
		
	if dive_times > 0:
		$DiveTime.stop()
		dive_times -= 1
		
		await get_tree().create_timer(0.2).timeout
		
		var shift = target_position_shift[randi() % target_position_shift.size()]
		shift += get_player_info()[2].x
		var new_pos = Vector2(shift, 650)
		monster.global_position = new_pos # 设置移到玩家头顶位置
		
		ani_2D.play("Dive") # 二次冲刺
		ready_to_dive = true
	else:
		release_barrage()
		get_parent().change_state(3)

func release_barrage(): # 召唤飞弹(deifan)弹幕
	var szfd = fd.instantiate()
	szfd.position = monster.global_position
	get_tree().current_scene.add_child(szfd)
