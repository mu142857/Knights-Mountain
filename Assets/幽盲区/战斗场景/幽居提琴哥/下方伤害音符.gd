extends Area2D

var is_hole: bool = false

func _ready() -> void:
	if is_hole:
		$AnimatedSprite2D.play("1.0")
	else:
		$AnimatedSprite2D.play("attack")

	$Timer.start(2)
	$AnimatedSprite2D.modulate = Color(0.6, 0.8, 1.0, 1.0)
	shift()

func shift():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, self.global_position.y), 2) 

func _on_timer_timeout() -> void:
	self.queue_free()

func _on_body_entered(body: Node2D) -> void:
	var arr = self.get_overlapping_bodies()
	attack_body(arr, 25)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
