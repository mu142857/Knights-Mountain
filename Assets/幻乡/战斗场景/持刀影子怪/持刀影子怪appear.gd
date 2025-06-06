extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	if shadow.global_position.x <= shadow.scene_startx:
		shadow.global_position.x = shadow.scene_startx
	elif shadow.global_position.x >= shadow.scene_endx:
		shadow.global_position.x = shadow.scene_endx
		
	shadow.show()
	ani_sprite2d.play("Appear")

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Appear":
		get_parent().change_state(3)
