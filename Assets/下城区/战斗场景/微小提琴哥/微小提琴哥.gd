extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 3600
var direct = 1 # 1 = 面向右边， -1 = 面向左边
var last_attack: int = 0

@export var small_or_big: String = "small"
var real_scale: float = 1.0

@onready var attack_check_position: Node2D = $AttackCheck

func _ready() -> void:
	#add_to_group("tatterer")
	add_to_group("monster")
	small_or_big = "small"
	$StateMachine.change_state(0)

func take_hit(value: int):
	if $AnimatedSprite2D.animation == "Gigantic":
		return
	elif health <= 2200:
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(7)
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	if small_or_big == "small":
		real_scale = 1.0
	else:
		real_scale = 3.0
	
	$AnimatedSprite2D.scale.x = real_scale * direct
	$AnimatedSprite2D.scale.y = real_scale
	
func change_scale():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", 3, 2.875) 

func face_left():
	$CollisionShape2D.scale.x = -1
	direct = -1
	attack_check_position.scale.x = -1
	
func face_right():
	$CollisionShape2D.scale.x = 1
	direct = 1
	attack_check_position.scale.x = 1
