extends RayCast2D

# 后台字段，存储实际状态
var _is_casting: bool = false

# 对外暴露的属性，带 getter/setter
@export var is_casting: bool:
	get:
		return _is_casting
	set(value):
		# 更新后台字段
		_is_casting = value
		# 触发效果
		if _is_casting:
			appear()
		else:
			disappear()
		# 根据状态开启/关闭物理帧处理
		set_physics_process(_is_casting)

func _ready() -> void:
	# 初始时关闭物理处理，避免未激活时的检测
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO

func cast_beem():
		# 直接对属性赋值，会触发上面的 set 块
	is_casting = true
	$Timer.start(1.5)

func _physics_process(delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		# 将碰撞点转换到本地坐标
		cast_point = to_local(get_collision_point())
	$Line2D.points[1] = cast_point

func appear():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($Line2D, "width", 1, 0.3)
	tween.play()

func disappear():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($Line2D, "width", 0, 0.01)
	tween.play()

func _on_timer_timeout() -> void:
	is_casting = false
