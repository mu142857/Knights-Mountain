extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attacks: Node2D = $"../../AttackChecks"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var tramp: bool = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter():
	if !monster.is_on_floor():
		ani_2D.play("Fall")
	
func process():
	if !monster.is_on_floor():
		monster.velocity.y = 2000
		monster.move_and_slide()
		return
	else:
		var diff: float = direction_calculation()
		
		if tramp == true:
			get_parent().change_state(3)
			tramp = !tramp
			$Timer.start(20)
			return
			
		var prob: int = randi_range(0, 13) # 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13
										  # 2  1  3  1  3  1  2  1  3  1   3   1   2                  # 远, 冲刺:6, 攻击:3, 结晶:4
										  # 3  2  1  2  1  2  3  2  1  2   1   2   3                  # 近, 冲刺:4, 攻击:6, 结晶:3
		if diff > 200: # 远距离情况
			if prob % 3 == 1: # 冲刺1, 攻击2, 结晶3
				get_parent().change_state(2)
				return
			else: 
				get_parent().change_state(1)
				return
		else: # 近距离情况
			if prob % 3 == 1:
				get_parent().change_state(1)
				return
			else: 
				get_parent().change_state(2)
				return
		
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

func _on_timer_timeout() -> void:
	tramp = true
