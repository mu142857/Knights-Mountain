extends CharacterBody2D

@export var type: String = "矮"
@export var swing_strength: float
@export var swing_time_period: float

var rotation_left: bool = true
@onready var mat = $AnimatedSprite2D.material as ShaderMaterial

func _process(delta: float) -> void:
	$AnimatedSprite2D.animation = type
	mat.set_shader_parameter("Strength", swing_strength)
	mat.set_shader_parameter("Speed", swing_time_period)
