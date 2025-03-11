extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	monster.show()
	ani_2D.play("SkillStart")

func process():
	pass

func exit():
	pass
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SkillStart":
		get_parent().change_state(6)
