extends Basic_State

@onready var player: CharacterBody2D = $"../.." # 导入玩家

func enter():
	$"../../AnimatedSprite2D".play("Idle") # 播放动画
	
func process():
	if !player.is_on_floor():
		get_parent().change_state(5)
		return
	var vec: Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("horizontal_left", "horizontal_right")
	if Input.is_action_just_pressed("horizontal_jump") and $"../Jump".ready_to_jump:
		get_parent().change_state(4)
		return
	elif vec.x != 0:
		get_parent().change_state(1)
		return
	elif Input.is_action_just_pressed("horizontal_attack1"):
		get_parent().change_state(8)
		return
	elif Input.is_action_just_pressed("horizontal_sprint") and $"../Sprint".ready_to_sprint:
		get_parent().change_state(9)
		return
	
	player.velocity = Vector2(0, 1)
	player.move_and_slide()
	
func exit():
	pass
