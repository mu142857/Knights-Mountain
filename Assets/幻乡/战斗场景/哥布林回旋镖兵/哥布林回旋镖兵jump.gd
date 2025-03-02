extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_speed: float = -200
const SPEED = 200

func enter():
	ani_2D.play("Jump")
	monster.velocity.y = jump_speed

func process():
	if monster.velocity.y > 0:
		get_parent().change_state(2)
		return
		
	monster.velocity.x = monster.direct.x * SPEED
	monster.velocity.y += 12.5
	monster.move_and_slide()
