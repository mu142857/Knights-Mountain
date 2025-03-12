extends Area2D

@onready var detection_range: Area2D = $PlayerCheck  # 玩家检测区域
var player: CharacterBody2D = null

# 子弹参数
var speed: float = 400.0           # 移动速度
var turn_rate: float = 0.18        # 每帧转向比例（0~1），数值越低转向越慢

func _ready() -> void:
	$Timer.start(5)
	$AnimatedSprite2D.play("Start")

func _physics_process(delta: float) -> void:
	
	self.z_index = 1
	if self.global_position.y >= 800 and $AnimatedSprite2D.animation != "Stop":
		Game.shake_camera(22)
		Game.flash(0.2, Color(3.0, 0.6, 0.58))
		self.global_position.y = 845
		self.rotation_degrees = 0
		$AnimatedSprite2D.play("Stop")
		return
	elif self.global_position.y >= 800:
		self.rotation_degrees = 0
		return
		
	find_player()  # 每帧检测玩家是否进入区域
	if player:
		# 计算从子弹当前位置指向玩家的位置的归一化向量
		var to_player: Vector2 = (player.global_position - global_position).normalized()
		# 目标角度
		var target_angle: float = to_player.angle()
		# 使用lerp_angle()平滑转向，使得子弹不会立即对准玩家
		rotation = lerp_angle(rotation, target_angle, turn_rate)
	
	# 根据当前角度计算速度向量，并更新位置
	var velocity: Vector2 = Vector2(cos(rotation), sin(rotation)) * speed
	
	if $AnimatedSprite2D.animation == "Spin":
		global_position += velocity * delta
		
	if speed <= 1000:
		speed += 10
	if turn_rate >=0.007:
		turn_rate -= 0.001

func find_player() -> void:
	var bodies: Array = detection_range.get_overlapping_bodies()
	player = null  # 每帧先重置player
	for body in bodies:
		if body.is_in_group("player"):
			player = body
			break

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Start":
		$AnimatedSprite2D.play("Spin")
	elif $AnimatedSprite2D.animation == "Stop":
		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()
