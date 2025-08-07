extends CharacterBody2D # 封尘的石刻

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 5000
var direct = 1 # 1 = 面向右边， -1 = 面向左边
var last_attack: int = 0
# const ANI_2D_SCALE: int = 1.5 不能写这行，得直接用数字

@onready var attack_check_position: Node2D = $AttackCheck

var stage: int = 1 # 1, 2, 3 Stages

func _ready() -> void:
	
	velocity = Vector2.ZERO
	
	add_to_group("monster")
	#$StateMachine.change_state(2)
	#$CanvasLayer/HealthBar.value = health

func take_hit(value: int):

	if stage <= 2:
		health -= value
		$HitEffectPlayer.play("HitFlash")
	else:
		health += value
		$HitEffectPlayer.play("HitFlash")
	if health <= 0:
		$StateMachine.change_state(9)
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	
	$AnimatedSprite2D.scale.x = (1.5 * direct)
	$AnimatedSprite2D.scale.y = (1.5)
	
	$CollisionShape2D.scale.x = direct
	$CollisionShape2D.scale.y = 1
	
	attack_check_position.scale.x = direct
	attack_check_position.scale.y = 1
	
	if stage == 1 and health <= 3000:
		stage = 2
	elif stage == 2 and health <= 1000:
		stage = 3
	
	#$CanvasLayer/Label.text = str(health)
	#$CanvasLayer/HealthBar.value = health

func face_left():
	direct = -1
	
func face_right():
	direct = 1
