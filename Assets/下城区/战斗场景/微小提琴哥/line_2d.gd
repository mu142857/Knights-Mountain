extends Line2D

@export var point_count = 250
@export var is_spawn = false

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
	if $"../../AnimatedSprite2D".animation == "SmallAppear":
		self.modulate.a -= 0.04
	add_point($"../../AnimatedSprite2D".global_position + Vector2(0, -80))
