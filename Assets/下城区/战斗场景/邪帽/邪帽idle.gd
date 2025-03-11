extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attacks: Node2D = $"../../SummonPoint"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	monster.show()
	if monster.ready_to_underground_fire == true:
		$Timer.start(0)
		return
	elif !monster.health >= 1990:
		var time = monster.health / 1000
		$Timer.start(time)
	ani_2D.play("Idle")
	
func process():
	if !monster.is_on_floor():
		monster.velocity.y = 4000
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

func _on_timer_timeout() -> void:
	if monster.is_on_floor() and monster.global_position.y >= 700:
		get_parent().change_state(2)
