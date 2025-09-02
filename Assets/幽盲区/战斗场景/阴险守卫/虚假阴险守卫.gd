extends CharacterBody2D

var direct = 1 # 1 = 面向右边， -1 = 面向左边
var low_road: bool = true
var time: float = 3.0

func _ready() -> void:
	time = 4.75
	self.modulate = Color(0.1, 0.1, 0.1, 0.2)
	$AnimatedSprite2D.play("Walking")
	$DeathTimer.start(5)

	if low_road:
		self.global_position.y = 846
	else:
		self.global_position.y = 690
	
	if direct == 1:
		self.global_position.x = -170
	else:
		self.global_position.x = 1570

	run()

func _physics_process(delta: float) -> void:
	
	$AnimatedSprite2D.scale.x = (2 * -direct)
	$AnimatedSprite2D.scale.y = (2)
	
	$CollisionShape2D.scale.x = -direct
	$CollisionShape2D.scale.y = 1

	$AttackCheck.scale.x = -direct
	$AttackCheck.scale.y = 1


func face_left():
	direct = -1
	
func face_right():
	direct = 1

func run():
	var tween = create_tween()
	
	if direct == 1 and low_road:
		tween.tween_property(self, "position", Vector2(1570, 846), time) 
	elif direct == -1 and low_road:
		tween.tween_property(self, "position", Vector2(-170, 846), time) 
	elif direct == 1 and !low_road:
		tween.tween_property(self, "position", Vector2(1570, 690), time) 
	else:
		tween.tween_property(self, "position", Vector2(-170, 690), time) 

func _on_death_timer_timeout() -> void:
	self.queue_free()

func _on_attack_check_body_entered(body: Node2D) -> void:
	var arr = $AttackCheck.get_overlapping_bodies()
	attack_body(arr, 34)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
