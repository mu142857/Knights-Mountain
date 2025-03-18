extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attacks: Node2D = $"../../SummonPoint"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Idle")
	
func process():
	if !monster.is_on_floor():
		monster.velocity.y = 3000
		monster.move_and_slide()
		return
	else:
		var diff: float = direction_calculation()
		
func exit():
	pass

func direction_calculation():
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				if i.global_position.x > monster.global_position.x:
					monster.direct = Vector2.RIGHT
					ani_2D.scale.x = 2
					attacks.scale.x = 1
				else:
					monster.direct = Vector2.LEFT
					ani_2D.scale.x = -2
					attacks.scale.x = -1
				return abs(i.global_position.x - monster.global_position.x)
