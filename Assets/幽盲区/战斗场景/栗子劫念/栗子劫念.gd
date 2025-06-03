extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 6500
var direct = 1 # 1 = 面向右边， -1 = 面向左边
var last_attack: int = 0

@onready var attack_check_position: Node2D = $AttackCheck

var second_stage: bool = false

func _ready() -> void:
	
	velocity = Vector2.ZERO
	
	add_to_group("monster")
	$StateMachine.change_state(0)
	
	$"眼泪点/栗子眼泪右".emitting = false
	$"眼泪点/栗子眼泪左".emitting = false
	
	$CanvasLayer/HealthBar.value = health

func take_hit(value: int):

	if !second_stage:
		health -= value
		$HitEffectPlayer.play("HitFlash")
	else:
		health -= (value * 4)
		$HitEffectPlayer.play("HitFlash")
	if health <= 0:
		$StateMachine.change_state(7)
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
	
	if second_stage == false and health <= 5000:
		$"眼泪点/栗子眼泪右".emitting = true
		$"眼泪点/栗子眼泪左".emitting = true
		second_stage = true
	
	attack_check()
	$CanvasLayer/Label.text = str(health)
	$CanvasLayer/HealthBar.value = health
	
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
		if i.is_in_group("player") and $AnimatedSprite2D.animation != "Appear" and $AnimatedSprite2D.animation != "Disappear":
			i.take_hit(7)
