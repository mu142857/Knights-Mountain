extends CharacterBody2D # 奥斯卡画的溃军首领

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 2100
var direct = Vector2.LEFT

func _ready() -> void:
	add_to_group("goblin")
	add_to_group("monster")
	$StateMachine.change_state(7)

func take_hit(value: int):
	if $AnimatedSprite2D.animation != "Idle":
		health -= value
		$HitEffectPlayer.play("HitFlash")
	if health <= 0:
		$StateMachine.change_state(5)

func _physics_process(delta: float) -> void:
	$CanvasLayer/Label.text = str(health)
	$CanvasLayer/HealthBar.value = health
	pass
