extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 4000
var direct = Vector2.LEFT

var health_level: int = 0
var venue_level: int = 0

@onready var checkerboard_left: CharacterBody2D = $"残灯移动棋盘/残灯移动棋盘左"
@onready var checkerboard_right: CharacterBody2D = $"残灯移动棋盘/残灯移动棋盘右"

func _ready() -> void:
	
	#add_to_group("tatterer")
	add_to_group("monster")
	$StateMachine.change_state(0)
	
	checkerboard_left.left_or_right = "left"
	checkerboard_right.left_or_right = "right"
	checkerboard_left.global_position =  Vector2(-50, 1060)
	checkerboard_right.global_position = Vector2(1450, 1060)

func take_hit(value: int):
	if health <= 0:
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(4)

	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	#print(randi_range(0, 1))
	pass
