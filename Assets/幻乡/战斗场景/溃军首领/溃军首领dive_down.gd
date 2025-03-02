extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	monster.velocity.y = 300
	monster.show()
	ani_2D.play("DiveDown")
	
func process():
	if monster.is_on_floor() and monster.global_position.y > 700:
		get_parent().change_state(4)
		return
	monster.velocity.y += 120
	monster.move_and_slide()

func exit():
	pass
