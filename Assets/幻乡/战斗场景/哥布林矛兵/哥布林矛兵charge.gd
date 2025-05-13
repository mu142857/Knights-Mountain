extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attack_range: Area2D = $"../../Attack Check"

var left_limit: float # 限制怪物移动位置
var right_limit: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 400.0

func enter():
	left_limit = monster.scene_startx + 20
	right_limit = monster.scene_endx - 40
	ani_2D.play("Charge")
	$Tired.start(4)
	
func process():
	if !monster.is_on_floor():
		monster.velocity.y += 40
		monster.move_and_slide() 	
		return
	else:
		afterimage()

	if monster.global_position.x >= right_limit:
		monster.direct = Vector2.LEFT
		ani_2D.scale.x = -1.84
		attack_range.scale.x = -1
	elif monster.global_position.x <= left_limit:
		monster.direct = Vector2.RIGHT
		ani_2D.scale.x = 1.84
		attack_range.scale.x = 1
		
	if $"../Run".ready_to_attack:
		var arr: Array = attack_range.get_overlapping_bodies()
		if arr.size() > 0:
			for i in arr:
				if i.is_in_group("player"):
					i.take_hit(10)
					get_parent().change_state(2)
					return
					
	monster.velocity = monster.direct * SPEED
	monster.velocity.y = gravity
	monster.move_and_slide()

func exit():
	pass

func _on_tired_timeout() -> void:
	if ani_2D.animation == "Charge":
		get_parent().change_state(0)
		
func afterimage():
	var afterimage = preload("res://Assets/幻乡/战斗场景/哥布林矛兵/长矛拖尾.tscn").instantiate()
	afterimage.scl = ani_2D.scale
	afterimage.global_position = monster.global_position
	monster.get_parent().add_child(afterimage)
