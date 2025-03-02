extends Basic_State

var speed: float = 400 # 一般的基础速度
@onready var player: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	if ani_sprite2d.animation == "RunStop" or ani_sprite2d.animation == "RunLoop":
		get_parent().change_state(2)
	else:
		ani_sprite2d.play("RunInitial")

func process():
	if !player.is_on_floor():
		get_parent().change_state(5)
		return
	elif Input.is_action_just_pressed("horizontal_jump") and $"../Jump".ready_to_jump:
		get_parent().change_state(4)
		return
	elif Input.is_action_just_pressed("horizontal_sprint") and $"../Sprint".ready_to_sprint:
		get_parent().change_state(9)
		return
	elif Input.is_action_just_pressed("horizontal_attack1"):
		get_parent().change_state(8)
		return

#冲！
	var vec: Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("horizontal_left", "horizontal_right")
	if vec.x == 0:
		get_parent().change_state(0)
		return
	elif vec.x > 0:
		ani_sprite2d.scale.x = 1
		$"../../AttackChecks".scale.x = 1
	else:
		ani_sprite2d.scale.x = -1
		$"../../AttackChecks".scale.x = -1
	player.velocity = speed * vec
	player.velocity.y = 1
	player.move_and_slide() 

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "RunInitial":
		get_parent().change_state(2)

func exit():
	pass
