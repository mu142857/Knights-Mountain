extends Area2D

var type: int
var x_speed: float
var y_speed: float

func _ready() -> void:
	match type:
		0:
			self.global_rotation = 0
			x_speed = 9
			y_speed = 0
		1:
			self.global_rotation = 45
			x_speed = 9
			y_speed = -9
		2:
			self.global_rotation = 90
			x_speed = 0
			y_speed = -9
		3:
			self.global_rotation = 135
			x_speed = -9
			y_speed = -9
		4:
			self.global_rotation = 180
			x_speed = -9
			y_speed = 0
		5:
			self.global_rotation = 225
			x_speed = -9
			y_speed = 9
		6:
			self.global_rotation = 270
			x_speed = 0
			y_speed = 9
		7:
			self.global_rotation = 315
			x_speed = 9
			y_speed = 9
		_:
			self.queue_free()

	$Timer.start(6)

func _physics_process(delta: float) -> void:
	self.position.x += x_speed
	self.position.y += y_speed

func _on_timer_timeout() -> void:
	queue_free()
