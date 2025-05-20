extends Area2D

var is_hole

func _ready() -> void:
	
	if is_hole:
		$AnimatedSprite2D.play("1.0")
	else:
		$AnimatedSprite2D.play("attack")
		
	$Timer.start(1)
	$AnimatedSprite2D.modulate = Color(1.0, 0.6, 0.6, 1.0)
	shift()

func shift():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(700, self.global_position.y), 1) 

func _on_timer_timeout() -> void:
	var deifan15 = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥飞弹.tscn").instantiate()
	deifan15.position = self.global_position
	deifan15.modulate = Color(1, 0.6, 0.6)
	deifan15.barrage_position = 15
	get_tree().current_scene.add_child(deifan15)
	self.queue_free()
