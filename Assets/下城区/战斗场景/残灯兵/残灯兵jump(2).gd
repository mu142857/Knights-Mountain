extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

# 自身跳跃方向
var jump_direction: int = 0
var y_addi: float = -1000
var x_addi: float = 0.0

func enter():
	var distance = get_player_direction()[0]
	y_addi = -600 - (distance / 1)
	x_addi = 120 + (distance / 2.5)
	
	ani_2D.play("Jump")
	monster.velocity.y = y_addi
	jump_direction = get_player_direction()[1]
	monster.velocity.x = x_addi * jump_direction
	
func process():
	if monster.velocity.y > 0:
		get_parent().change_state(3)
		return

	monster.velocity.y += 30
	monster.move_and_slide()

func get_player_direction() -> Array:
	var direction: int = 0
	var distance = 0.0
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				direction = sign(i.global_position.x - monster.global_position.x)
				distance = abs(i.global_position.x - monster.global_position.x)
	return [distance, direction] # direction中，-1表示左边，1表示右边，0表示未知

# 受击反弹函数
func take_hit():
	var dir = get_player_direction()[1]
	
	monster.position.x -= 10 * dir
	monster.position.y -= 10
	monster.move_and_slide()
