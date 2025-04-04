extends Area2D

var y_add = 10

func _ready() -> void:
	$AnimationPlayer.play("Arrow")
	self.modulate.a = 0
	y_add = 10
	
func _physics_process(delta: float) -> void:
	
	if $AnimatedSprite2D.animation == "Ready":
		self.modulate.a += 0.01
		return
		
	if $AnimatedSprite2D.animation == "Falling":
		
		self.modulate.a = 1
		self.global_position.y += y_add
		y_add += 1
		return
		
	if $AnimatedSprite2D.animation == "End":
		
		self.modulate.a -= 0.05
		return

func _process(delta: float) -> void:
	if self.global_position.y >= 815:
		$AnimationPlayer.stop()
		$AnimatedSprite2D.play("End")

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Ready":
		$AnimationPlayer.stop()
		$AnimatedSprite2D.play("Falling")
	if $AnimatedSprite2D.animation == "End":
		self.queue_free()
