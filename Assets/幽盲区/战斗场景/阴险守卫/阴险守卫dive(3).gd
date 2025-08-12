extends Basic_State #4

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var luodilizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑落地粒子.tscn")
var yinfulizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")
var fr = preload("res://Assets/幽盲区/战斗场景/阴险守卫/阴险守卫地火.tscn")
var random_pos: int

func enter():
	$ReleaseEffectTimer.start(0.55)

	random_pos = randi_range(0, 3) # 0为左，1为中，2为右
	
	if random_pos == 1:
		monster.global_position = Vector2(700, 690)
	elif random_pos == 0:
		monster.global_position = Vector2(160, 846)
	elif random_pos == 2:
		monster.global_position = Vector2(1240, 846)
	else:
		monster.global_position = Vector2(700, 846)

	ani_2D.play("Dive")
	

func process():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Dive":
		monster.global_position = Vector2(0, -500)
		get_parent().change_state(1)

func release_effect():
	#attack_check()
	
	var expl = luodilizi.instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
	Game.shake_camera(40)
	var note = yinfulizi.instantiate()
	note.position = monster.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)
	
func exit():
	pass

func attack_check():
	#var arr = $"../../AttackCheck/冲撞".get_overlapping_bodies()
	#for i in arr:
	#	if i.is_in_group("player"):
	#		i.take_hit(30)
	pass

func _on_dive_time_timeout() -> void:
	attack_check()
	release_effect()
	#print(dive_times)

func _on_release_effect_timer_timeout() -> void:
	if random_pos == 1:
		summon_fire_mid()
	elif random_pos == 0:
		summon_fire_l()
	elif random_pos == 2:
		summon_fire_r()
	else:
		summon_fire_bottom()
	release_effect()

func summon_fire_mid():
	var dur = 0.1
	
	var f1 = fr.instantiate()
	var f2 = fr.instantiate()
	var f3 = fr.instantiate()
	var f4 = fr.instantiate()
	var f5 = fr.instantiate()
	var f6 = fr.instantiate()
	var f7 = fr.instantiate()
	var f8 = fr.instantiate()
	#var f9 = fr.instantiate()
	#var f10 = fr.instantiate()
	var f11 = fr.instantiate()
	var f12 = fr.instantiate()
	var f13 = fr.instantiate()
	var f14 = fr.instantiate()
	var f15 = fr.instantiate()
	var f16 = fr.instantiate()
	var f17 = fr.instantiate()
	var f18 = fr.instantiate()
	#var f19 = fr.instantiate()
	#var f20 = fr.instantiate()
	f1.global_position = Vector2(655, 690)
	f2.global_position = Vector2(565, 690)
	f3.global_position = Vector2(475, 690)
	f4.global_position = Vector2(385, 690)
	f5.global_position = Vector2(295, 850)
	f6.global_position = Vector2(205, 850)
	f7.global_position = Vector2(115, 850)
	f8.global_position = Vector2(25, 850)
	f11.global_position = Vector2(745, 690)
	f12.global_position = Vector2(835, 690)
	f13.global_position = Vector2(925, 690)
	f14.global_position = Vector2(1015, 690)
	f15.global_position = Vector2(1105, 850)
	f16.global_position = Vector2(1195, 850)
	f17.global_position = Vector2(1285, 850)
	f18.global_position = Vector2(1375, 850)
	get_tree().current_scene.add_child(f1)
	get_tree().current_scene.add_child(f11)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f2)
	get_tree().current_scene.add_child(f12)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f3)
	get_tree().current_scene.add_child(f13)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f4)
	get_tree().current_scene.add_child(f14)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f5)
	get_tree().current_scene.add_child(f15)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f6)
	get_tree().current_scene.add_child(f16)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f7)
	get_tree().current_scene.add_child(f17)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f8)
	get_tree().current_scene.add_child(f18)

func summon_fire_l():
	var dur = 0.1
	
	var f1 = fr.instantiate()
	var f2 = fr.instantiate()
	var f3 = fr.instantiate()
	var f4 = fr.instantiate()
	var f5 = fr.instantiate()
	var f6 = fr.instantiate()
	var f7 = fr.instantiate()
	var f8 = fr.instantiate()
	var f11 = fr.instantiate()
	var f12 = fr.instantiate()
	var f13 = fr.instantiate()
	var f14 = fr.instantiate()
	var f15 = fr.instantiate()
	var f16 = fr.instantiate()
	var f17 = fr.instantiate()
	var f18 = fr.instantiate()
	f1.global_position = Vector2(655, 690)
	f2.global_position = Vector2(565, 690)
	f3.global_position = Vector2(475, 690)
	f4.global_position = Vector2(385, 690)
	f5.global_position = Vector2(295, 850)
	f6.global_position = Vector2(205, 850)
	f7.global_position = Vector2(115, 850)
	f8.global_position = Vector2(25, 850)
	f11.global_position = Vector2(745, 690)
	f12.global_position = Vector2(835, 690)
	f13.global_position = Vector2(925, 690)
	f14.global_position = Vector2(1015, 690)
	f15.global_position = Vector2(1105, 850)
	f16.global_position = Vector2(1195, 850)
	f17.global_position = Vector2(1285, 850)
	f18.global_position = Vector2(1375, 850)
	get_tree().current_scene.add_child(f6)
	get_tree().current_scene.add_child(f7)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f5)
	get_tree().current_scene.add_child(f8)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f4)
	get_tree().current_scene.add_child(f18)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f3)
	get_tree().current_scene.add_child(f17)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f2)
	get_tree().current_scene.add_child(f16)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f1)
	get_tree().current_scene.add_child(f15)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f11)
	get_tree().current_scene.add_child(f14)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f12)
	get_tree().current_scene.add_child(f13)

func summon_fire_r():
	var dur = 0.1
	
	var f1 = fr.instantiate()
	var f2 = fr.instantiate()
	var f3 = fr.instantiate()
	var f4 = fr.instantiate()
	var f5 = fr.instantiate()
	var f6 = fr.instantiate()
	var f7 = fr.instantiate()
	var f8 = fr.instantiate()
	var f11 = fr.instantiate()
	var f12 = fr.instantiate()
	var f13 = fr.instantiate()
	var f14 = fr.instantiate()
	var f15 = fr.instantiate()
	var f16 = fr.instantiate()
	var f17 = fr.instantiate()
	var f18 = fr.instantiate()
	f1.global_position = Vector2(655, 690)
	f2.global_position = Vector2(565, 690)
	f3.global_position = Vector2(475, 690)
	f4.global_position = Vector2(385, 690)
	f5.global_position = Vector2(295, 850)
	f6.global_position = Vector2(205, 850)
	f7.global_position = Vector2(115, 850)
	f8.global_position = Vector2(25, 850)
	f11.global_position = Vector2(745, 690)
	f12.global_position = Vector2(835, 690)
	f13.global_position = Vector2(925, 690)
	f14.global_position = Vector2(1015, 690)
	f15.global_position = Vector2(1105, 850)
	f16.global_position = Vector2(1195, 850)
	f17.global_position = Vector2(1285, 850)
	f18.global_position = Vector2(1375, 850)
	get_tree().current_scene.add_child(f16)
	get_tree().current_scene.add_child(f17)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f15)
	get_tree().current_scene.add_child(f18)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f14)
	get_tree().current_scene.add_child(f8)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f13)
	get_tree().current_scene.add_child(f7)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f12)
	get_tree().current_scene.add_child(f6)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f11)
	get_tree().current_scene.add_child(f5)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f1)
	get_tree().current_scene.add_child(f4)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f2)
	get_tree().current_scene.add_child(f3)

func summon_fire_bottom():
	var dur = 0.1
	
	var f1 = fr.instantiate()
	var f2 = fr.instantiate()
	var f3 = fr.instantiate()
	var f4 = fr.instantiate()
	var f5 = fr.instantiate()
	var f6 = fr.instantiate()
	var f7 = fr.instantiate()
	var f8 = fr.instantiate()
	#var f9 = fr.instantiate()
	#var f10 = fr.instantiate()
	var f11 = fr.instantiate()
	var f12 = fr.instantiate()
	var f13 = fr.instantiate()
	var f14 = fr.instantiate()
	var f15 = fr.instantiate()
	var f16 = fr.instantiate()
	var f17 = fr.instantiate()
	var f18 = fr.instantiate()
	#var f19 = fr.instantiate()
	#var f20 = fr.instantiate()
	f1.global_position = Vector2(655, 850)
	f2.global_position = Vector2(565, 850)
	f3.global_position = Vector2(475, 850)
	f4.global_position = Vector2(385, 850)
	f5.global_position = Vector2(385, 690)
	f6.global_position = Vector2(475, 690)
	f7.global_position = Vector2(565, 690)
	f8.global_position = Vector2(655, 690)
	f11.global_position = Vector2(745, 850)
	f12.global_position = Vector2(835, 850)
	f13.global_position = Vector2(925, 850)
	f14.global_position = Vector2(1015, 850)
	f15.global_position = Vector2(1015, 690)
	f16.global_position = Vector2(925, 690)
	f17.global_position = Vector2(835, 690)
	f18.global_position = Vector2(745, 690)
	get_tree().current_scene.add_child(f1)
	get_tree().current_scene.add_child(f11)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f2)
	get_tree().current_scene.add_child(f12)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f3)
	get_tree().current_scene.add_child(f13)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f4)
	get_tree().current_scene.add_child(f14)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f5)
	get_tree().current_scene.add_child(f15)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f6)
	get_tree().current_scene.add_child(f16)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f7)
	get_tree().current_scene.add_child(f17)
	await get_tree().create_timer(dur).timeout
	get_tree().current_scene.add_child(f8)
	get_tree().current_scene.add_child(f18)
