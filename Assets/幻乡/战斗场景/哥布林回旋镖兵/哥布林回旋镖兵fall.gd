extends Basic_State

const SPEED: float = 200
@onready var monster: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	ani_sprite2d.play("Fall")

func process():
	if monster.is_on_floor():
		get_parent().change_state(0)
		return	
		
	monster.velocity.x = monster.direct.x * SPEED
	monster.velocity.y += 12.5
	monster.move_and_slide() 

func exit():
	pass
