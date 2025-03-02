# Boomerang.gd
extends Area2D

# 椭圆参数
@export var ellipse_width := 180.0
@export var ellipse_height := -200.0

# 运动参数
@export var base_speed := 5.5
@export var acceleration := 0.5
@export var lifetime := 2.4

var _a: float
var _b: float
var _theta: float
var _direction: int
var _angular_velocity: float
var _timer := 0.0
var _center: Vector2
var _y_shift: float = 0.1
var _max_y: float = 900.0

func setup(thrower_pos: Vector2, is_clockwise: bool, max_y: float) -> void:
	
	_max_y = max_y
	$AnimatedSprite2D.play("Fly")
	
	# 计算椭圆参数（半长轴和半短轴）
	_a = ellipse_width / 2.0
	_b = ellipse_height / 2.0
	
	# 初始化角度（起始于椭圆底部）
	_theta = 3.0 * PI / 2.0
	
	# 设置旋转方向
	_direction = 1 if is_clockwise else -1
	
	# 计算椭圆中心（位于投掷者上方）
	_center = thrower_pos + Vector2(0, _b)
	
	# 初始位置设为投掷者位置
	self.global_position = thrower_pos
	
	# 初始角速度
	_angular_velocity = base_speed
	
	# 根据方向调整回旋镖朝向
	if _direction == -1:
		scale.x = -scale.x

func _physics_process(delta: float) -> void:
	
	if self.global_position.y > _max_y - 10:
		destroy()
		return
	
	_y_shift *= 1.07
	
	_timer += delta
	if _timer >= lifetime:
		queue_free()
		return
	
	# 加速效果
	_angular_velocity += acceleration * delta
	
	# 更新角度
	_theta += _direction * _angular_velocity * delta
	
	# 计算椭圆轨迹坐标
	var x = _a * cos(_theta)
	var y = _b * sin(_theta) + _y_shift
	self.global_position = _center + Vector2(x, y)
	
	# 旋转效果（每秒360度）
	self.rotation += _direction * PI * 2 * delta
	
	# 淡出效果
	#self.modulate.a = 1.0 - ((_timer - 1) / (lifetime - 1))

func _on_body_entered(body: Node2D) -> void:
	var arr = self.get_overlapping_bodies()
	attack_body(arr, 10)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			#i.take_hit(damage)
			destroy()
		
			
func destroy():
	self.rotation_degrees = 0
	$AnimatedSprite2D.play("Destroy")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Destroy":
		self.queue_free()
