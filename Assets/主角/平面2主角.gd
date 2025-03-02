extends CharacterBody2D

@export var move_speed: float = 100
@export var animator : AnimatedSprite2D 
var pause = false

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if not pause:
		
		velocity = Input.get_vector("flat_left", "flat_right", "flat_up", "flat_down") * move_speed
		if velocity ==  Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		move_and_slide()
