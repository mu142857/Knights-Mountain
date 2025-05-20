extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var ready_to_sprint: bool = false

func enter():
	ready_to_sprint = false
	monster.velocity.y = -3000
	ani_2D.play("Jump")

func process():
	pass
