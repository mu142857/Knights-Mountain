extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

var jiguanglizi = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子激光粒子.tscn")

func enter():
	ani_player.play("upperlaser")

func release_effect():
	Game.shake_camera(10)
	var expl = jiguanglizi.instantiate()
	expl.position = $"../../AttackCheck/上激光发射点".global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "ReleaseLaser":
		get_parent().change_state(0)
