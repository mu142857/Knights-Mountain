extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

const MIN_RUNNING_DISTANCE: float = 300
const MAX_RUNNING_DISTANCE: float = 700
const SAFETY_DISTANCE: float = 400
var target_position: Vector2 = Vector2(0, 845.997)

func enter():
	ani_2D.play("BigRun")

func target_postion_calculation():
	var player_x = get_player_info()[2].x
	var target_x = player_x + ((randi() % 2) * 2 - 1)
	
func get_player_info() -> Array:
	var direction: int = 0
	var distance: float = 0.0
	var position: Vector2 = Vector2.ZERO
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				direction = sign(i.global_position.x - monster.global_position.x)
				distance = abs(i.global_position.x - monster.global_position.x)
				position = i.global_position
	return [distance, direction, position] # direction中，-1表示(在主角)左边，1表示右边，0表示未知
