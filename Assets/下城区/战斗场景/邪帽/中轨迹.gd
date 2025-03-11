extends Line2D

@export var point_count = 80
@export var is_spawn = true

func _ready() -> void:
	self.modulate.a = 1
	clear_points()

func _physics_process(delta: float) -> void:
	if is_spawn:
		if get_point_count() > point_count:
			remove_point(0)
		draw_point()
	else:
		if get_point_count() > 0:
			remove_point(0)
		
func draw_point():
	if $"../../AnimatedSprite2D".animation == "Spin":
		add_point($"../../AnimatedSprite2D".global_position)
	elif $"../../AnimatedSprite2D".animation == "Stop":
		self.modulate.a -= 0.1
