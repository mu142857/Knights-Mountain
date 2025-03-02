extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0

func _ready() -> void:
	add_to_group("shadow")
	add_to_group("monster")
	$StateMachine.change_state(0)

func take_hit(value: int):
	var _v = value
	$StateMachine.change_state(4)

	
