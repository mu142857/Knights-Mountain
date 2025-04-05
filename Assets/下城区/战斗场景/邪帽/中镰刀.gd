extends Area2D

@onready var detection_range: Area2D = $PlayerCheck  # 玩家检测区域
var player: CharacterBody2D = null

@export var flight_time: float = 0.7      # 子弹飞行总时间（秒）
var the_gravity: float = 6000.0       # 重力（像素/秒²）

var start_pos: Vector2                  # 子弹起始位置
var target_pos: Vector2                 # 玩家初始位置（记录下来，不再更新）
var velocity: Vector2 = Vector2.ZERO    # 初始速度

func _ready() -> void:
	$AnimatedSprite2D.play("Start")

func _physics_process(delta: float) -> void:
	
	if $AnimatedSprite2D.animation != "Spin":
		return
	
	self.z_index = 1 # 全镰刀通用部分
	if self.global_position.y >= 810 and $AnimatedSprite2D.animation != "Stop":
		Game.shake_camera(15)
		Game.flash(0.2, Color(3.0, 0.6, 0.58))
		self.global_position.y = 845
		self.rotation_degrees = 0
		var expl = preload("res://Assets/下城区/战斗场景/邪帽/中等爆炸.tscn").instantiate()
		expl.position = self.global_position
		expl.emitting = true
		get_tree().current_scene.add_child(expl)
		$AnimatedSprite2D.play("Stop")
		return
	elif self.global_position.y >= 810:
		self.rotation_degrees = 0
		return
	
	# 重力作用，更新垂直速度（注意：Godot中y轴向下为正）
	velocity.y += the_gravity * delta
	# 更新子弹位置
	global_position += velocity * delta

func find_player() -> void:
	var bodies: Array = detection_range.get_overlapping_bodies()
	player = null  # 每次先重置
	for body in bodies:
		if body.is_in_group("player"):
			player = body
			break

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Start":
		# 记录子弹生成时的位置
		start_pos = self.global_position
		# 使用和之前相同的方式检测玩家
		find_player()
		if player:
			target_pos = player.global_position + Vector2(randi_range(-175, 175), 0)
		else:
			target_pos = self.global_position  # 如果没有检测到玩家，就默认目标位置为自身（避免错误）
	
		# 计算初始速度
		# 水平速度： vx = (目标x - 起始x) / flight_timed
		# 垂直速度： vy = (目标y - 起始y - 0.5 * gravity * flight_time²) / flight_time
		velocity.x = (target_pos.x - start_pos.x) / flight_time
		velocity.y = (target_pos.y - start_pos.y - 0.5 * the_gravity * flight_time * flight_time) / flight_time
		$AnimatedSprite2D.play("Spin")
		
	elif $AnimatedSprite2D.animation == "Stop":
		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()
