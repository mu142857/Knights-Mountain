extends Camera2D

@export var recovery_speed: float = 32.0
var shake_strength: float = 0.0

@onready var colour_rect: ColorRect = $CanvasLayer/ColorRect
var blink_strength: float = 0.0
var rect_colour: Color

func _ready() -> void:
	Game.screen_shake.connect(func(amount: float):
		if shake_strength < amount * 2:
			shake_strength += amount 
	)
	Game.screen_flash.connect(func(amount: float, colour: Color):
		if shake_strength < 5:
			blink_strength += amount 
			rect_colour = colour
	)

func _process(delta: float) ->  void:
	
	offset = Vector2( # 震动
		randf_range(-shake_strength, +shake_strength),
		randf_range(-shake_strength, +shake_strength)
	)
	shake_strength = move_toward(shake_strength, 0, recovery_speed * delta)
	
	colour_rect.modulate = rect_colour
	colour_rect.modulate.a = randf_range(blink_strength / 2, blink_strength) # 闪烁
	blink_strength = move_toward(blink_strength, 0, recovery_speed * delta)
