extends Area2D

@onready var detection_range: Area2D = $PlayerCheck  # 玩家检测区域
var player: CharacterBody2D = null

@export var flight_time: float = 1      # 子弹飞行总时间（秒）
var the_gravity: float = 3000.0       # 重力（像素/秒²）

var start_pos: Vector2                  # 子弹起始位置
var target_pos: Vector2                 # 玩家初始位置（记录下来，不再更新）
var velocity: Vector2 = Vector2.ZERO    # 初始速度
var barrage_position: int = 0	# 1为左，2为中，3为右
var position_change: float = 0

func _ready() -> void:
	$AnimatedSprite2D.play("Ready")
	cauculate_barrage_position()
	
	if barrage_position <= 7:
		flight_time = 1
		the_gravity = 3000
		$Summon.start(0.3)
	elif  barrage_position <= 14:
		flight_time = 1.2
		the_gravity = 3500
		$Summon.start(0.6)

func _physics_process(delta: float) -> void:
	
	if $AnimatedSprite2D.animation != "Move":
		return
	
	self.z_index = 1 # 全镰刀通用部分
	if self.global_position.y >= 810 and $AnimatedSprite2D.animation != "Stop":
		
		Game.flash(0.2, Color(3.0, 0.6, 0.58))
		self.global_position.y = 845
		self.rotation_degrees = 0
		var gyph = preload("res://Assets/下城区/战斗场景/微小提琴哥/高音谱号落地特效.tscn").instantiate()
		gyph.position = self.global_position
		gyph.emitting = true
		get_tree().current_scene.add_child(gyph)
		var expl = preload("res://Assets/下城区/战斗场景/微小提琴哥/小型音符粒子.tscn").instantiate()
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
	self.global_position += velocity * delta
	# 子弹旋转
	update_rotation()

func find_player() -> void:
	var bodies: Array = detection_range.get_overlapping_bodies()
	player = null  # 每次先重置
	for body in bodies:
		if body.is_in_group("player"):
			player = body
			break

func _on_animated_sprite_2d_animation_finished() -> void:
	$Node/Line2D.is_spawn = true
	
	if $AnimatedSprite2D.animation == "Ready":
		# 记录子弹生成时的位置
		start_pos = self.global_position
		# 使用和之前相同的方式检测玩家
		find_player()

		if player and barrage_position <= 7:
			target_pos = player.global_position + Vector2(position_change, 0)
		elif player and barrage_position <= 14:
			target_pos = Vector2(700, player.global_position.y) + Vector2(position_change, 0)
			pass
		else:
			target_pos = self.global_position  # 如果没有检测到玩家，就默认目标位置为自身（避免错误）
	
		# 计算初始速度
		# 水平速度： vx = (目标x - 起始x) / flight_timed
		# 垂直速度： vy = (目标y - 起始y - 0.5 * gravity * flight_time²) / flight_time
		velocity.x = (target_pos.x - start_pos.x) / flight_time
		velocity.y = (target_pos.y - start_pos.y - 0.5 * the_gravity * flight_time * flight_time) / flight_time
		$AnimatedSprite2D.play("Move")
		
	elif $AnimatedSprite2D.animation == "Stop":
		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()

func update_rotation() -> void:
	rotation_degrees = velocity.angle() * 180.0 / PI

func cauculate_barrage_position():
	match barrage_position:
		0:
			position_change = 0
		1:
			position_change = -200
		2:
			position_change = 0
		3:
			position_change = 200
		4:
			position_change = -450
		5:
			position_change = -150
		6:
			position_change = 150
		7:
			position_change = 450
		8:
			position_change = -600
		9:
			position_change = -400
		10:
			position_change = -200
		11:
			position_change = 0
		12:
			position_change = 200
		13:
			position_change = 400
		14:
			position_change = 600

func _on_summon_timeout() -> void:
	var expl = preload("res://Assets/下城区/战斗场景/微小提琴哥/小型音符粒子.tscn").instantiate()
	expl.position = self.global_position
	expl.emitting = true
	get_tree().current_scene.add_child(expl)
