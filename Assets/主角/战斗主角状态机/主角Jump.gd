extends Basic_State

var speed: float = 200
var jump_speed: float = -700
var is_jumping: bool = false
var ready_to_jump: bool = true
@onready var player: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	if ready_to_jump:
		is_jumping = true
		ready_to_jump = false
		$Timer.start(0.8)
		ani_sprite2d.play("Jump")
		player.velocity.y = jump_speed

func process():
	if is_jumping and player.velocity.y > 0:
		get_parent().change_state(5)
		return
	var vec: Vector2 = Vector2.ZERO
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
	if Input.is_action_just_pressed("horizontal_sprint") and $"../Sprint".ready_to_sprint:
		get_parent().change_state(9)
		return

func exit():
	player.velocity.y = 0
	is_jumping = false

func _on_timer_timeout() -> void:
	ready_to_jump = true
