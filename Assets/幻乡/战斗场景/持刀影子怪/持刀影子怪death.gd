extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	ani_sprite2d.play("Death")

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Death":
		$"../..".queue_free()
