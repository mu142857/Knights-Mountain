extends CharacterBody2D # 身法哥画的白影子

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 1100
var direct = Vector2.LEFT

func _ready() -> void:
	add_to_group("shadows")
	add_to_group("monster")
	$StateMachine.change_state(0)

func take_hit(value: int):
	if health <= 0:
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(5)
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")
		
func _physics_process(delta: float) -> void:
	#print($AnimatedSprite2D.animation)
	pass
