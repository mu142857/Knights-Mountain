extends Area2D

var vec_x: float = 1.0
var y_increase: float = 0.0
var is_exploding: bool = false

func _ready():
	$"火球粒子".modulate.a = 1
	self.rotation = randf_range(0, 360)
	$Timer.start(10)

	y_increase = 20.0
	if vec_x < 0:
		self.scale.x = -1

func _physics_process(delta: float) -> void:
	if $"火球粒子".modulate.a > 0.5:
		$"火球粒子".modulate.a -= 0.01
	else:
		$"火球粒子".modulate.a = 0.5
	self.rotation -= 0.1
	var arr: Array = []
	self.position.x += 4 * vec_x
	if y_increase > 0:
		y_increase -= 0.17
	else:
		y_increase = 0
		
	self.position.y += cos(y_increase) * y_increase * 0.5
	arr = self.get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			#i.take_hit(6)
			pass

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	var arr = self.get_overlapping_bodies()
	attack_body(arr, 20)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
