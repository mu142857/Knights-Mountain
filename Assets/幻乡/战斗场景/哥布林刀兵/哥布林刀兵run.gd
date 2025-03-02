extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attack_range: Area2D = $"../../AttackChecks/AttackRange" # 触发攻击的范围
@onready var attacks: Node2D = $"../../AttackChecks"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 120.0

var left_limit: float # 限制怪物移动位置
var right_limit: float

func enter():
	left_limit = monster.scene_startx + 20
	right_limit = monster.scene_endx - 40
	ani_2D.play("Run")
	
	direction_calculation()
	
func process():
	if !monster.is_on_floor():
		monster.velocity.y = 1800
		monster.move_and_slide()
		return
		
	var arr: Array = attack_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				get_parent().change_state(3)
				return

	direction_calculation()

	monster.velocity.x = monster.direct.x * SPEED
	monster.move_and_slide()
	
func exit():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Run":
		var prob: int = randf_range(0, 10)
		if prob % 3 == 0:
			get_parent().change_state(1)
		else:
			get_parent().change_state(0)

func direction_calculation():
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				if i.global_position.x < monster.scene_startx or i.global_position.x > monster.scene_endx: # 玩家不再可遇范围
					if monster.is_on_floor(): # 如果在地上，随便走
						default_direction()
					else: # 如果未落地，设置向右
						monster.direct = Vector2.RIGHT
						ani_2D.scale.x = 1.84
						attack_range.scale.x = 1
						attacks.scale.x = 1
				elif i.global_position > monster.global_position:
					monster.direct = Vector2.RIGHT
					ani_2D.scale.x = 1.84
					attack_range.scale.x = 1
					attacks.scale.x = 1
				else:
					monster.direct = Vector2.LEFT
					ani_2D.scale.x = -1.84
					attack_range.scale.x = -1
					attacks.scale.x = -1
	
func default_direction():
	if monster.global_position.x >= right_limit:
		monster.direct = Vector2.LEFT
		ani_2D.scale.x = -1.84
		attack_range.scale.x = -1
		attacks.scale.x = -1
	if monster.global_position.x <= left_limit:
		monster.direct = Vector2.RIGHT
		ani_2D.scale.x = 1.84
		attack_range.scale.x = 1
		attacks.scale.x = 1
