extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 135.0

var left_limit: float # 限制怪物移动位置
var right_limit: float

func enter():
	left_limit = monster.scene_startx + 20
	right_limit = monster.scene_endx - 40
	ani_2D.play("Run")
	
	direction_calculation()
	
func process():
	if !monster.is_on_floor():
		monster.velocity.y = 1500
		
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player") and abs(i.global_position.x - monster.global_position.x) <= 150: # 视野
				get_parent().change_state(1)
				return

	direction_calculation()

	monster.velocity.x = monster.direct.x * SPEED
	monster.move_and_slide()
	
func exit():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Run":
		get_parent().change_state(0)

func direction_calculation():
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				if i.global_position.x < monster.scene_startx or i.global_position.x > monster.scene_endx: # 玩家不再可遇范围
					if monster.is_on_floor(): # 如果在地上，随便走
						default_direction()
					else: # 如果未落地，设置向左
						monster.direct = Vector2.RIGHT
						ani_2D.scale.x = 1.84
				elif i.global_position > monster.global_position:
					monster.direct = Vector2.RIGHT
					ani_2D.scale.x = 1.84
				else:
					monster.direct = Vector2.LEFT
					ani_2D.scale.x = -1.84
	
func default_direction():
	if monster.global_position.x >= right_limit:
		monster.direct = Vector2.LEFT
		ani_2D.scale.x = -1.84
	if monster.global_position.x <= left_limit:
		monster.direct = Vector2.RIGHT
		ani_2D.scale.x = 1.84
