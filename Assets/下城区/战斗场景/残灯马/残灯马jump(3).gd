extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

# 自身跳跃方向
var jump_direction: int = 0

func enter():

	monster.velocity.y = -500
	if monster.global_position.x >= (monster.scene_endx - 80):
		jump_direction = 1
	elif monster.global_position.x <= (monster.scene_startx + 80):
		jump_direction = -1
	else:
		jump_direction = get_player_direction()[1]
	
	monster.velocity.x = -200 * jump_direction
	
func process():
	if monster.velocity.y > 0:
		get_parent().change_state(4)
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
