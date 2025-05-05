extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 120
var direct = Vector2.LEFT

func _ready() -> void:
	add_to_group("tatterer")
	add_to_group("monster")
	$StateMachine.change_state(5)

func take_hit(value: int):
	if health <= 0:
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(4)

	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")
		if $AnimatedSprite2D.animation == "Jump":
			$"StateMachine/Jump(2)".take_hit()
		elif $AnimatedSprite2D.animation == "Fall":
			$"StateMachine/Fall(3)".take_hit()

func _physics_process(delta: float) -> void:
	#print($AnimatedSprite2D.animation)
	pass
