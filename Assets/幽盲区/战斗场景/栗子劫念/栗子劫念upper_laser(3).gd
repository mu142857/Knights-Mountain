extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var jiguanglizi = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子激光粒子.tscn")
var shuij = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子掉落水晶.tscn")

func enter():
	ani_player.play("upperlaser")

func exit():
	ani_player.stop()

func release_effect():
	Game.shake_camera(10)
	var expl = jiguanglizi.instantiate()
	expl.position = $"../../AttackCheck/上激光发射点".global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "ReleaseLaser":
		get_parent().change_state(0)

func release_c():
	var sj1 = shuij.instantiate()
	var sj2 = shuij.instantiate()
	var sj3 = shuij.instantiate()
	var sj4 = shuij.instantiate()
	var sj5 = shuij.instantiate()
	var sj6 = shuij.instantiate()
	sj1.position = Vector2(monster.global_position.x + randf_range(10, 100), 0)
	sj2.position = Vector2(monster.global_position.x - randf_range(10, 100), 0)
	sj3.position = Vector2(monster.global_position.x + randf_range(110, 300), 0)
	sj4.position = Vector2(monster.global_position.x - randf_range(110, 300), 0)
	sj5.position = Vector2(monster.global_position.x + randf_range(310, 600), 0)
	sj6.position = Vector2(monster.global_position.x - randf_range(310, 600), 0)
	get_tree().current_scene.add_child(sj1)
	get_tree().current_scene.add_child(sj2)
	get_tree().current_scene.add_child(sj3)
	get_tree().current_scene.add_child(sj4)
	get_tree().current_scene.add_child(sj5)
	get_tree().current_scene.add_child(sj6)
	
