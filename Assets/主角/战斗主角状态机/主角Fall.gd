extends Basic_State

var speed: float = 300
@onready var player: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	ani_sprite2d.play("Fall")

func process():
	if player.is_on_floor():
		get_parent().change_state(0)
		return

	var vec: Vector2 = Vector2.ZERO
	if Input.is_action_just_pressed("horizontal_sprint") and $"../Sprint".ready_to_sprint:
		get_parent().change_state(9)
		return
	vec.x = Input.get_axis("horizontal_left", "horizontal_right")
	if vec.x > 0:
		ani_sprite2d.scale.x = 1
		$"../../AttackChecks".scale.x = 1
	elif vec.x < 0:
		ani_sprite2d.scale.x = -1
		$"../../AttackChecks".scale.x = -1
	player.velocity.x = vec.x * speed
	player.velocity.y += 30
	player.move_and_slide() 

func exit():
	pass
