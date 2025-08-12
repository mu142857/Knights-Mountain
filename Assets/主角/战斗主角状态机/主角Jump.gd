extends Basic_State

var speed: float = 300
var jump_speed: float = -400
var is_jumping: bool = false
var ready_to_jump: bool = true
@onready var player: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var jump_effect: GPUParticles2D = $"../../跳跃加速度粒子"

# 控制跳跃高度的可调参数
@export var max_jump_hold_time: float = 0.3    # 最长按住跳跃维持时间（秒）
@export var hold_gravity_multiplier: float = -0.3  # 按住时的重力倍率（越小上升越久）
var _jump_elapsed: float = 0.0 # 已经长按的时间

# 每帧加速度，不使用gravity
var _base_gravity_per_frame: float = 50.0

func enter():

	if ready_to_jump:
		is_jumping = true
		ready_to_jump = false
		_jump_elapsed = 0.0
		$Timer.start(0.1)
		ani_sprite2d.play("Jump")
		player.velocity.y = jump_speed

func process():
	if player.velocity.y <= -500:
		jump_effect.emitting = true
	else:
		jump_effect.emitting = false

	# 使用物理帧时间来累加按住时长（更稳定）
	var dt = get_physics_process_delta_time()

	if is_jumping and player.velocity.y > 0: # 如果向下速度大于0，切换为下落状态
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
	
		# 可控跳跃逻辑
	if is_jumping:
		# 如果还在按住跳跃键并且没超过允许的最长保持时间，就用较小的“重力”让上升持续更久
		# 注意：这里假设你的跳跃按键名为 "ui_jump"，如果不是请改成你项目里的名字
		if Input.is_action_pressed("horizontal_jump") and _jump_elapsed < max_jump_hold_time:
			_jump_elapsed += dt
			player.velocity.y += _base_gravity_per_frame * hold_gravity_multiplier
		else:
			# 松开或达到时间上限，取消 'is_jumping'，恢复正常重力，角色会进入下落阶段
			is_jumping = false
			player.velocity.y += _base_gravity_per_frame
	else:
		# 正常重力（下落或未在跳跃保持中）
		player.velocity.y += _base_gravity_per_frame

	# 当垂直速度变为向下（>0）时，切换为你现有的下落状态（你原本用的是 state 5）
	if player.velocity.y > 0:
		get_parent().change_state(5)
		return

	player.move_and_slide()

	if Input.is_action_just_pressed("horizontal_sprint") and $"../Sprint".ready_to_sprint:
		get_parent().change_state(9)
		return

func exit():
	player.velocity.y = 0
	is_jumping = false
	_jump_elapsed = 0.0
	jump_effect.emitting = false

func _on_timer_timeout() -> void:
	ready_to_jump = true
