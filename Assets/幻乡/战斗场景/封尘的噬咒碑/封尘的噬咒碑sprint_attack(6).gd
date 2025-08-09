extends Basic_State #6

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var lizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")
var u_fire = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑地火炸弹.tscn")

func enter():
	ani_2D.play("SprintDigDown")
	
	# 释放粒子
	var note = lizi.instantiate()
	note.position = monster.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)

func process():
	if ani_2D.animation == "Sprinting": # 碰撞伤害开
		monster.global_position.y = 900
		attack_check()
	else:
		monster.global_position.y = 845.997

func exit():
	ani_player.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SprintDigDown":
		monster.global_position = Vector2(0, 0)
		$DigginigTime.start(0.5)
	elif ani_2D.animation == "SprintDigUp":
		ani_2D.play("SprintPrepare")
	elif ani_2D.animation == "SprintPrepare":
		if monster.stage <= 2:
			ani_player.play("sprint")
		else:
			ani_player.play("hardsprint")
		ani_2D.play("Sprinting")
		$SprintingTime.start(0.3)
		# 使用Tween冲刺
		var tween = create_tween()
		tween.set_trans(Tween.TRANS_QUART)  # 四次缓动曲线
		tween.set_ease(Tween.EASE_IN_OUT)  # 加速后减速
		tween.tween_property(monster, "position", Vector2(1340, 900), 0.3) 
	elif ani_2D.animation == "SprintDone":
		ani_2D.play("Idle")

func _on_digginig_time_timeout() -> void:
	monster.global_position = Vector2(70, 845.997)
	ani_2D.play("SprintDigUp")

func _on_sprinting_time_timeout() -> void:
	ani_2D.play("SprintDone")

func release_barrage_underground_fire(x: float): # 召唤飞弹弹幕()
	var szfd = u_fire.instantiate()
	var szfd_pos = Vector2(x, -20)
	var szfd_tpos = Vector2(x, 810)
	szfd.position = szfd_pos
	szfd.target_pos = szfd_tpos
	get_tree().current_scene.add_child(szfd)

func change_to_idle():
	get_parent().change_state(5)

func attack_check():
	var arr = $"../../AttackCheck/冲刺下".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(40)
