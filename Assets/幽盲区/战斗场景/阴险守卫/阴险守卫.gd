extends CharacterBody2D # 阴险守卫

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 1000
var direct = 1 # 1 = 面向右边， -1 = 面向左边
var last_attack: int = 0

@onready var attack_check_position: Node2D = $AttackCheck

var stage: int = 1 # 1, 2 Stages; boss有2阶段

func _ready() -> void:
	
	velocity = Vector2.ZERO
	
	add_to_group("monster")
	#$StateMachine.change_state(2)
	#$CanvasLayer/HealthBar.value = health

func take_hit(value: int):

	if $AnimatedSprite2D.animation!= "Dive":
		health -= value
		$HitEffectPlayer.play("HitFlash")
		
	if health <= 0:
		$StateMachine.change_state(9)
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	
	$AnimatedSprite2D.scale.x = (2 * direct)
	$AnimatedSprite2D.scale.y = (2)
	
	$CollisionShape2D.scale.x = direct
	$CollisionShape2D.scale.y = 1

	$AttackAlert.scale.x = direct
	$AttackAlert.scale.y = 1
	
	attack_check_position.scale.x = direct
	attack_check_position.scale.y = 1
	
	if stage == 1 and health <= 500:
		stage = 2
	
	#$CanvasLayer/Label.text = str(health)
	#$CanvasLayer/HealthBar.value = health

func face_left():
	direct = -1
	
func face_right():
	direct = 1
