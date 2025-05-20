extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 1300
var direct = 1 # 1 = 面向右边， -1 = 面向左边
var last_attack: int = 0

var is_mad = false
@onready var attack_check_position: Node2D = $AttackCheck

func _ready() -> void:
	#add_to_group("tatterer")
	add_to_group("monster")
	$StateMachine.change_state(0)
	is_mad = false

func take_hit(value: int):
	if health <= 650 and !is_mad:
		$StateMachine.change_state(3)
		$HitEffectPlayer.play("HitFlash")
		is_mad = true
		return
	elif health <= 0:
		$StateMachine.change_state(8)
		$HitEffectPlayer.play("HitFlash")
		return
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:

	$AnimatedSprite2D.scale.x = direct * 3
	$AnimatedSprite2D.scale.y = 3
	
	$CollisionShape2D.scale.x =  direct
	$CollisionShape2D.scale.y = 1
	
	attack_check_position.scale.x = direct
	attack_check_position.scale.y = 1
	
func change_scale():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", 3, 2.875) 

func face_left():
	direct = -1
	
func face_right():
	direct = 1
