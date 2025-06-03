extends CharacterBody2D

@export var speed: float = 1200.0
@export var max_bounce: int = 3
var bounce_count: int = 0

var explosion_scene = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子水晶爆炸粒子.tscn")

func _ready() -> void:
	$Node/Line2D.is_spawn = true
	$Sprite2D.modulate.a = 1
	$Node/Line2D.modulate.a = 1
	
func _physics_process(delta):
	
	if velocity == Vector2.ZERO:
		self.modulate.a -= 0.01
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		release_effect()
		velocity = velocity.bounce(collision.get_normal())
		bounce_count += 1
		if bounce_count >= max_bounce:
			velocity = Vector2.ZERO
			$Timer.start(1.5)

	# 更新旋转角度，使节点朝向当前速度方向
	if velocity.length() > 0:
		rotation = velocity.angle()

func release_effect():
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	explosion.emitting = true
	get_tree().current_scene.add_child(explosion)

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if modulate.a >= 1:
		var arr = $Area2D.get_overlapping_bodies()
		attack_body(arr, 17)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			self.queue_free()
			i.take_hit(damage)
