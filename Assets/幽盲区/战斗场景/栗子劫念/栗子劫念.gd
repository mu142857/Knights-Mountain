extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 3500
var direct = 1 # 1 = 面向右边， -1 = 面向左边
var last_attack: int = 0

@onready var attack_check_position: Node2D = $AttackCheck

var second_stage: bool = false

func _ready() -> void:
	
	add_to_group("monster")
	$StateMachine.change_state(0)
	
	$"眼泪点/栗子眼泪右".emitting = false
	$"眼泪点/栗子眼泪左".emitting = false

func take_hit(value: int):

	if health <= 0:
		$StateMachine.change_state(7)
		$HitEffectPlayer.play("HitFlash")
	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	
	$AnimatedSprite2D.scale.x = 2 * direct
	$AnimatedSprite2D.scale.y = 2

	$"眼泪点".scale.x = 2 * direct
	$"眼泪点".scale.y = 2
	
	$CollisionShape2D.scale.x = 2 * direct
	$CollisionShape2D.scale.y = 2
	
	attack_check_position.scale.x = 2 * direct
	attack_check_position.scale.y = 2
	
	if second_stage == false and health <= 2000:
		second_stage == true
		$"眼泪点/栗子眼泪右".emitting = true
		$"眼泪点/栗子眼泪左".emitting = true
	
	attack_check()
	
func change_scale():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", 3, 2.875) 

func face_left():
	direct = -1
	
func face_right():
	direct = 1

func attack_check():
	var arr = $"AttackCheck/碰撞伤害".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(5)
