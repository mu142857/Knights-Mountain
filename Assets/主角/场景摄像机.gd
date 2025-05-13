extends Camera2D

@export var recovery_speed: float = 32.0
var shake_strength: float = 0.0

@onready var colour_rect1: ColorRect = $CanvasLayer/ColorRect1
@onready var colour_rect2: ColorRect = $CanvasLayer/ColorRect2

var blink_time_1: float = 0.0   # 剩余闪烁时长（秒）
@export var blink_duration_1: float = 0.2  # 默认闪烁总时长
@export var max_blink_alpha_1: float = 1.0  # 最大不透明度
var rect1_colour: Color = Color(1,1,1,1)

var blink_time_2: float = 0.0   # 剩余闪烁时长（秒）
@export var blink_duration_2: float = 0.2  # 默认闪烁总时长
@export var max_blink_alpha_2: float = 1.0  # 最大不透明度
var rect2_colour: Color = Color(1,1,1,1)

func _ready() -> void:
	# 震动信号
	Game.screen_shake.connect(func(amount: float):
		shake_strength = max(shake_strength, amount)
	)
	# 闪烁信号：把 blink_time 设为一个持续时间
	Game.screen_flash.connect(func(amount: float, colour: Color):
		blink_time_1 = blink_duration_1 * amount  # amount 可用作闪烁倍率
		rect1_colour = colour
		max_blink_alpha_1 = colour.a
	)
	# 闪烁信号：把 blink_time 设为一个持续时间
	Game.screen_filter.connect(func(amount: float, colour: Color):
		blink_time_2 = blink_duration_2 * amount  # amount 可用作闪烁倍率
		rect2_colour = colour
		max_blink_alpha_2 = colour.a
	)

func _process(delta: float) -> void:
	# —— 屏幕震动 —— #
	offset = Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)
	shake_strength = move_toward(shake_strength, 0, recovery_speed * delta)

	# —— 屏幕闪烁 —— #
	if blink_time_1 > 0:
		# 计算当前透明度：剩余时间 / 总时间 * 最大 alpha
		var t = blink_time_1 / (blink_duration_1)
		colour_rect1.self_modulate = rect1_colour
		colour_rect1.modulate.a = t * max_blink_alpha_1
		blink_time_1 = max(blink_time_1 - delta, 0)
	else:
		# 闪烁结束
		colour_rect1.modulate.a = 0

	# —— 屏幕闪烁 —— #
	if blink_time_2 > 0:
		# 计算当前透明度：剩余时间 / 总时间 * 最大 alpha
		var t = blink_time_2 / (blink_duration_2)
		colour_rect2.self_modulate = rect2_colour
		colour_rect2.modulate.a = t * max_blink_alpha_2
		blink_time_2 = max(blink_time_2 - delta, 0)
	else:
		# 闪烁结束
		colour_rect2.modulate.a = 0
