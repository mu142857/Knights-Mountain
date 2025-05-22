extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 2500
var direct = 1 # 1 = 面向右边， -1 = 面向左边

@onready var attack_check_position: Node2D = $AttackCheck

func _ready() -> void:
	#add_to_group("tatterer")
	add_to_group("monster")
	$StateMachine.change_state(0)

func take_hit(value: int):

	if health <= 0:
		$StateMachine.change_state(15)
		$HitEffectPlayer.play("HitFlash")
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	
	$AnimatedSprite2D.scale.x = 1 * direct
	$AnimatedSprite2D.scale.y = 1
	
	$CollisionShape2D.scale.x = 1 * direct
	$CollisionShape2D.scale.y = 1
	
	attack_check_position.scale.x = 1 * direct
	attack_check_position.scale.y = 1
	
func change_scale():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", 3, 2.875) 

func face_left():
	direct = -1
	
func face_right():
	direct = 1
