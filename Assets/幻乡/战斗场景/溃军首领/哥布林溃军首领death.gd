extends Basic_State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var death_particle = preload("res://Assets/幻乡/战斗场景/溃军首领/溃军首领死亡粒子.tscn")
func enter():
	$Timer.start(0.3)
	animated_sprite_2d.play("Crystallization")

func _on_timer_timeout() -> void:
	Game.shake_camera(50)
	Game.flash(1, Color(0.243, 0.145, 0.184, 0.3))
	var exp = death_particle.instantiate()
	exp.position = monster.global_position
	exp.emitting = true
	get_tree().current_scene.add_child(exp)
	$"../..".queue_free()
