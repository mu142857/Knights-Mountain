extends CharacterBody2D # 奥斯卡画的邪帽

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health: float = 2000
var ready_to_underground_fire: bool = false
var direct = Vector2.LEFT

func _ready() -> void:
	add_to_group("pagan")
	add_to_group("monster")
	$StateMachine.change_state(0)

func take_hit(value: int):
	
	if $AnimatedSprite2D.animation == "Idle" and health >= 1990:
		$StateMachine.change_state(2)
		health -= value
	elif health <= 0 and $AnimatedSprite2D.animation != "Disappear":
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(8)
	elif $AnimatedSprite2D.animation != "Disappear":
		health -= value
		$HitEffectPlayer.play("HitFlash")
		
func _physics_process(delta: float) -> void:
	#print($AnimatedSprite2D.animation)
	#print(health)
	pass
