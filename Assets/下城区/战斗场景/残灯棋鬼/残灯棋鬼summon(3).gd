extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster: CharacterBody2D = $"../.."

func enter():
	ani_player.play("Summon")

func process():
	pass

func exit():
	ani_player.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	ani_2D.play("Idle")
	$AfterSummonDuration.start(1)

func _on_after_summon_duration_timeout() -> void:
	get_parent().change_state(1)

func release_hit_effect():
	Game.shake_camera(25)
	var expl = preload("res://Assets/下城区/战斗场景/残灯棋鬼/砸地粒子.tscn").instantiate()
	expl.position = monster.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
