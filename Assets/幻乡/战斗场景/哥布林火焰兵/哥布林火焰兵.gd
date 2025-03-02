extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 200
var direct = Vector2.RIGHT

func _ready() -> void:
	add_to_group("goblin")
	add_to_group("monster")
	$StateMachine.change_state(0)

func take_hit(value: int):
	if health <= 0:
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(4)
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")
		
