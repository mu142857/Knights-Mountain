extends Area2D # 地火炸弹

@export var flight_time: float = 1      # 子弹飞行总时间（秒）
var the_gravity: float = 6500.0       # 重力（像素/秒²）

var start_pos: Vector2                  # 子弹起始位置
var target_pos: Vector2                 # 子弹目标位置
var velocity: Vector2 = Vector2.ZERO    # 初始速度
var barrage_position: int = 0	# 1为左，2为中，3为右

var is_random: bool = false # 目标位置是否随机，否则瞄准玩家

var lz = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/石碑地火喷发粒子.tscn")

func _ready() -> void:
	
	$FlyingTime.start(1)
	$Timer.start(10)
	
	$AnimatedSprite2D.play("Ready")
	
	flight_time = 1
	the_gravity = 4000

func _physics_process(delta: float) -> void:
	
	if $AnimatedSprite2D.animation != "Flying":
		return
	
	# 重力作用，更新垂直速度（注意：Godot中y轴向下为正）
	velocity.y += the_gravity * delta
	# 更新子弹位置
	self.global_position += velocity * delta
	
	if global_position.y > 810:
		global_position.y = 810

func _on_animated_sprite_2d_animation_finished() -> void:
	$Node/Line2D.is_spawn = true
	
	if $AnimatedSprite2D.animation == "Ready":
		# 记录子弹生成时的位置
		start_pos = self.global_position
		# 使用和之前相同的方式检测玩家

		if target_pos == null:
			self.queue_free()
	
		# 计算初始速度
		# 水平速度： vx = (目标x - 起始x) / flight_timed
		# 垂直速度： vy = (目标y - 起始y - 0.5 * gravity * flight_time²) / flight_time

		velocity.x = (target_pos.x - start_pos.x) / flight_time
		velocity.y = (target_pos.y - start_pos.y - 0.5 * the_gravity * flight_time * flight_time) / flight_time
		$AnimatedSprite2D.play("Flying")
		
	elif $AnimatedSprite2D.animation == "Exploding":
		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()

#func _on_body_entered(body: Node2D) -> void:
	##var arr = self.get_overlapping_bodies()
	##attack_body(arr, 10)
	#pass
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)

func _on_flying_time_timeout() -> void:
	global_position.y = 810
	$AnimationPlayer.play("attack")

func attack_check():
	
	var arr = $AttackCheck.get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(35)

func release_effect():
	var note = lz.instantiate()
	note.position = self.global_position # 释放粒子
	note.emitting = true
	get_tree().current_scene.add_child(note)
	Game.flash(0.1, Color(3.0, 0.6, 0.58))
