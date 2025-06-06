extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Idle")
	monster.velocity.x = 0
	monster.velocity.y = 0

func process():
	if monster.is_on_floor() or monster.global_position.y >= 840:
		get_parent().change_state(0)
		return
		
	monster.velocity.y += 30
	monster.move_and_slide()

func exit():
	attack_check()
	
	Game.shake_camera(10)
	var expl = preload("res://Assets/下城区/战斗场景/残灯马/跳跃落地粒子.tscn").instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)

func attack_check():
	var arr = $"../../AttackCheck".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(30)
