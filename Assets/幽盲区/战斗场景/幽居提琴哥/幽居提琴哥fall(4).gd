extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Fall")

func process():
	if monster.is_on_floor() and monster.global_position.y > 800:
		get_parent().change_state(0)
		return

	monster.velocity.y += 30
	monster.move_and_slide() 

func exit():
	pass
