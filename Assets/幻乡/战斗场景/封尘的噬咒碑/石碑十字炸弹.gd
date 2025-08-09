extends Area2D # 十字炸弹

@onready var detection_range: Area2D = $PlayerCheck  # 玩家检测区域
var player: CharacterBody2D = null

@export var flight_time: float = 1  # 子弹飞行总时间（秒）
var the_gravity: float = 7000.0       # 重力（像素/秒²）

var start_pos: Vector2                  # 子弹起始位置
var target_pos: Vector2                 # 子弹目标位置
var velocity: Vector2 = Vector2.ZERO    # 初始速度

var yinfulizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")

func _ready() -> void:
	$AnimatedSprite2D.play("Ready")
	cauculate_barrage_position()
	
	$FlyingTime.start(0.75) # 计时器启动
	$Timer.start(10)
	
	flight_time = 0.75
	the_gravity = 7000

func _physics_process(delta: float) -> void:
	
	if $AnimatedSprite2D.animation != "Flying":
		return
	
	self.z_index = 1 # 全镰刀通用部分
	
	# 重力作用，更新垂直速度（注意：Godot中y轴向下为正）
	velocity.y += the_gravity * delta
	# 更新子弹位置
	self.global_position += velocity * delta

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

		if player:
			target_pos = player.global_position + Vector2(0, -350)
		else:
			target_pos = self.global_position  # 如果没有检测到玩家，就默认目标位置为自身（避免错误）
	
		velocity.x = (target_pos.x - start_pos.x) / flight_time
		velocity.y = (target_pos.y - start_pos.y - 0.5 * the_gravity * flight_time * flight_time) / flight_time
		$AnimatedSprite2D.play("Flying")
		
	elif $AnimatedSprite2D.animation == "Exploding":
		var note = yinfulizi.instantiate()
		note.position = self.global_position # 释放粒子
		note.emitting = true
		get_tree().current_scene.add_child(note)

		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()

func cauculate_barrage_position():
	pass # position_change

func _on_body_entered(body: Node2D) -> void:
	var arr = self.get_overlapping_bodies()
	#attack_body(arr, 25) # 暂时无伤害
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)

func _on_flying_time_timeout() -> void:
	Game.flash(0.2, Color(3.0, 0.6, 0.58))
	Game.shake_camera(10)
	
	# 发射十字激光
	aim()
	$AnimatedSprite2D.play("Exploding")

# 激光发射部分

@onready var beamtl: RayCast2D = $"石碑激光左上"
@onready var beambl: RayCast2D = $"石碑激光左下"
@onready var beamtr: RayCast2D = $"石碑激光右上"
@onready var beambr: RayCast2D = $"石碑激光右下"

func aim(): 
	beamtl.target_position = $"激光目标点/目标点左上".position
	beambl.target_position = $"激光目标点/目标点左下".position
	beamtr.target_position = $"激光目标点/目标点右上".position
	beambr.target_position = $"激光目标点/目标点右下".position
	attack()

func attack():
	beamtl.force_raycast_update()
	beambl.force_raycast_update()
	beamtr.force_raycast_update()
	beambr.force_raycast_update()
	beamtl.cast_beem()
	beambl.cast_beem()
	beamtr.cast_beem()
	beambr.cast_beem()
