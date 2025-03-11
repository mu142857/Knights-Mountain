extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	pass

func process():
	if !monster.is_on_floor() or monster.global_position.y < 700:
		monster.velocity.y = 12000
		monster.move_and_slide()
		return
	elif monster.visible == false:
		monster.show()
		ani_2D.play("Prominence")

func exit():
	pass
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Prominence":
		get_parent().change_state(7)
