extends  Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

var shuij = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子水晶爆炸粒子.tscn")

var state: String = "Jump"

# 自身跳跃方向
var jump_direction: int = 0
var y_addi: float = -1000
var x_addi: float = 0.0

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "BeforeSpin":
		var distance = get_player_direction()[0]
		y_addi = -2000
		x_addi = 120 + (distance / 2.5)
		ani_2D.play("Spin")
		monster.velocity.y = y_addi
		jump_direction = get_player_direction()[1]
		monster.velocity.x = x_addi * jump_direction
	if ani_2D.animation == "AfterSpin":
		get_parent().change_state(0)

func enter():
	monster.velocity = Vector2.ZERO
	if get_player_direction()[1] == 1:
		monster.face_left()
	else:
		monster.face_right()

	ani_2D.play("BeforeSpin")
	state = "Jump"
	
func process():
	if monster.is_on_floor() and monster.global_position.y > 700 and state == "Fall":
		ani_2D.play("AfterSpin")
		monster.velocity = Vector2.ZERO
		var expl = shuij.instantiate()
		expl.emitting = true
		expl.position = monster.global_position + Vector2(0, 40)
		get_tree().current_scene.add_child(expl)
		state = "Rest"
	if monster.velocity.y > 0:
		state = "Fall"

	monster.velocity.y += 50
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
