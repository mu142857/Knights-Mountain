extends GPUParticles2D


func _on_timer_timeout() -> void:
	self.queue_free()
