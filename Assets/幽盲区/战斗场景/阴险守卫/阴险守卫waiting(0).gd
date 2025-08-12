extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	monster.show()
	ani_2D.play("Idle")
	
func process():
	if monster.health < 999:
		get_parent().change_state(4)
