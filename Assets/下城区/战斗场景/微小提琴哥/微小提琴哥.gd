extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 2500
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
		#small_or_big = "big"
	elif health <= 1300 and small_or_big == "small":
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(7)
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")
	if health <= 0:
		$StateMachine.change_state(15)
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	if small_or_big == "small":
		real_scale = 1.0
		$PlayerCheck/CollisionShape2D.global_position = self.global_position
	
	$AnimatedSprite2D.scale.x = real_scale * direct
	$AnimatedSprite2D.scale.y = real_scale
	
	$CollisionShape2D.scale.x = real_scale * direct
	$CollisionShape2D.scale.y = real_scale
	
	attack_check_position.scale.x = real_scale * direct
	attack_check_position.scale.y = real_scale

	$CanvasLayer/Label.text = str(health)
	$CanvasLayer/HealthBar.value = health
	
func change_scale():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", 3, 2.875) 

func face_left():
	direct = -1
	
func face_right():
	direct = 1
