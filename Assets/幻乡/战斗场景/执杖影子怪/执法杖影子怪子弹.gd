extends Area2D

var vec_x: float = 1.0
var y_increase: float = 0.0
var is_exploding: bool = false

func _ready():
	is_exploding = false
	y_increase = 0.0
	if vec_x < 0:
		self.scale.x = -1

func _physics_process(delta: float) -> void:
	var arr: Array = []
	if not is_exploding:
		self.position.x += 18 * vec_x
		y_increase += 0.2
		self.position.y += sin(y_increase) * y_increase * 1.5
		arr = self.get_overlapping_bodies()
		for i in arr:
			if i.is_in_group("player"):
				$AnimatedSprite2D.stop()
				$AnimatedSprite2D.frame = 12
				$AnimatedSprite2D.play()
	else:
		arr = self.get_overlapping_bodies()
		for i in arr:
			if i.is_in_group("player"):
				#i.take_hit(6)
				pass
		

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.frame == 12:
		is_exploding = true
