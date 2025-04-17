extends GPUParticles2D

func _ready() -> void:
	$Timer.start(2)
	
func _on_timer_timeout() -> void:
	self.queue_free()
