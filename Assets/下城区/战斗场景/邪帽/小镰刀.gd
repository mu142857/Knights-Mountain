extends Area2D

enum State { INITIAL, TRACKING }

@onready var detection_range: Area2D = $PlayerCheck  # 玩家检测区域
var player: CharacterBody2D = null

# 当前状态
var state: State = State.INITIAL

# -----------------------------
# 追踪阶段参数
# -----------------------------
var track_speed: float = 900.0        # 追踪阶段移动速度
var track_turn_rate: float = 0.12     # 追踪阶段每帧转向比率

# -----------------------------
# 初始阶段（炫酷旋转）参数
# -----------------------------
@export var ellipse_width := 220.0    # 椭圆宽度
@export var ellipse_height := -220.0  # 椭圆高度
@export var base_speed := 10.0        # 初始角速度
@export var acceleration := 1.2       # 角速度加速度
@export var initial_lifetime := 0.75   # 初始阶段持续时间（秒）

var _a: float
var _b: float
var _theta: float
var _direction: int = 1               # 旋转方向，1为顺时针，-1为逆时针
var _angular_velocity: float
var _timer: float = 0.0
var _center: Vector2

func _ready() -> void:
	# 初始阶段动画（根据需求调整动画名）
	$AnimatedSprite2D.play("Start")
	
	$Timer.start(15)

func _physics_process(delta: float) -> void:
	
	self.z_index = 1
	if self.global_position.y >= 815 and $AnimatedSprite2D.animation != "Stop":
		Game.shake_camera(8)
		Game.flash(0.2, Color(2.5, 0.6, 2.0))
		self.global_position.y = 850
		self.rotation_degrees = 0
		$AnimatedSprite2D.play("Stop")
		return
	elif self.global_position.y >= 815:
		self.rotation_degrees = 0
		return
		
	if $AnimatedSprite2D.animation == "Spin":
		if state == State.INITIAL:
			_initial_phase(delta)
		elif state == State.TRACKING:
			_tracking_phase(delta)

func _initial_phase(delta: float) -> void:
	_timer += delta
	# 达到持续时间后切换到追踪阶段
	if _timer >= initial_lifetime:
		# 如果检测到玩家，先把角度调整为朝向玩家
		_find_player()
		if player:
			rotation = (player.global_position - global_position).angle()
		state = State.TRACKING
		$AnimatedSprite2D.play("Spin")  # 切换到追踪动画（根据需求）
		return
	
	# 更新角速度（加速效果）
	_angular_velocity += acceleration * delta
	# 更新角度（绕中心旋转）
	_theta += _direction * _angular_velocity * delta
	
	# 计算椭圆轨迹坐标
	var x: float = _a * cos(_theta)
	var y: float = _b * sin(_theta)
	global_position = _center + Vector2(x, y)
	
	# 附加旋转效果（纯视觉效果）
	rotation += _direction * PI * 2 * delta

func _tracking_phase(delta: float) -> void:
	_find_player()
	if player:
		# 计算子弹到玩家的归一化方向向量
		var to_player: Vector2 = (player.global_position - global_position).normalized()
		# 计算目标角度
		var target_angle: float = to_player.angle()
		# 平滑转向，让子弹不会瞬间对齐目标
		rotation = lerp_angle(rotation, target_angle, track_turn_rate)
	
	# 根据当前角度计算速度向量并更新位置
	var velocity: Vector2 = Vector2(cos(rotation), sin(rotation)) * track_speed
	global_position += velocity * delta
	if track_speed <= 1000:
		track_speed += 10
	if track_turn_rate >=0.007:
		track_turn_rate -= 0.001

func _find_player() -> void:
	var bodies: Array = detection_range.get_overlapping_bodies()
	player = null  # 每帧先重置
	for body in bodies:
		if body.is_in_group("player"):
			player = body
			break

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Start":
		$AnimatedSprite2D.play("Spin")
		# 初始化椭圆参数
		_a = ellipse_width / 2.0
		_b = ellipse_height / 2.0
		# 初始角度：从椭圆的底部开始（3π/2）
		_theta = 3.0 * PI / 2.0
		# 设定中心点：例如以当前子弹位置上移 _b 像素为中心
		_center = global_position + Vector2(0, _b)
		# 初始角速度
		_angular_velocity = base_speed
	elif $AnimatedSprite2D.animation == "Stop":
		self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()


func _on_animated_sprite_2d_animation_changed() -> void:
	if $AnimatedSprite2D.animation == "Stop":
		var expl = preload("res://Assets/下城区/战斗场景/邪帽/镰刀爆炸.tscn").instantiate()
		expl.position = self.global_position
		expl.emitting = true
		get_tree().current_scene.add_child(expl)

func _on_body_entered(body: Node2D) -> void:
	if $AnimatedSprite2D.animation == "Spin":
		var arr = self.get_overlapping_bodies()
		attack_body(arr, 20)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
