extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

func enter():
	ani_2D.play("Disappear")

func process():
	pass

func exit():
	monster.global_position.x = randf_range(monster.scene_startx + 200, monster.scene_endx - 200)
	ani_2D.modulate = Color(1.1, 1.6, 1.4)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Disappear":
		monster.set_collision_layer_value(4, false)
		get_parent().change_state(5)
