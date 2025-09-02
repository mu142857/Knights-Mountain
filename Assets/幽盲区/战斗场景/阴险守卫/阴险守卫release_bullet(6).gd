extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var zd = preload("res://Assets/幽盲区/战斗场景/阴险守卫/险恶子弹.tscn") # 子弹
var bz = preload("res://Assets/下城区/战斗场景/邪帽/镰刀爆炸.tscn") # 粒子效果

var attack_times: int = 4 # 攻击次数
var position_list: Array = [Vector2(940,690), Vector2(460,690),
							Vector2(1100,846), Vector2(300,846), Vector2(890,846), Vector2(510,846),]
var random_pos: int

func enter():
	monster.hide()
	random_pos = randi_range(0, 5)
	monster.global_position = position_list[random_pos]
	if monster.global_position.x < 700:
		monster.face_left()
	else:
		monster.face_right()
	ani_player.play("ReleaseBullet")

func process():
	if attack_times <= 0:
		attack_times = 4
		get_parent().change_state(1)

func exit():
	monster.global_position = Vector2(0, -500)
	ani_player.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "ReleaseBullet":
		attack_times -= 1
		get_parent().change_state(6)

func release_bullet():
	var bullet1 = zd.instantiate()
	bullet1.type = 0
	bullet1.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet1)
	var bullet2 = zd.instantiate()
	bullet2.type = 1
	bullet2.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet2)
	var bullet3 = zd.instantiate()
	bullet3.type = 2
	bullet3.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet3)
	var bullet4 = zd.instantiate()
	bullet4.type = 3
	bullet4.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet4)
	var bullet5 = zd.instantiate()
	bullet5.type = 4
	bullet5.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet5)
	var bullet6 = zd.instantiate()
	bullet6.type = 5
	bullet6.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet6)
	var bullet7 = zd.instantiate()
	bullet7.type = 6
	bullet7.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet7)
	var bullet8 = zd.instantiate()
	bullet8.type = 7
	bullet8.position = $"../../AttackCheck/Bullet".global_position
	get_tree().current_scene.add_child(bullet8)
	var expl = bz.instantiate()
	expl.position = $"../../AttackCheck/Bullet".global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)

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

func show_monst():
	monster.show()
