extends Node2D

var direct: int = 0 # -1 为左, 1 为右
var speed_num: float = 4

func _ready() -> void:
	self.global_position.y = 850
	
func _physics_process(delta: float) -> void:
	var x = speed_num * direct
	self.global_position.x += x
	speed_num += 0.4

func _on_timer_timeout() -> void:
	var wave = preload("res://Assets/下城区/战斗场景/微小提琴哥/提琴波.tscn").instantiate()
	wave.position = self.global_position
	get_tree().current_scene.add_child(wave)
	
	var note = preload("res://Assets/下城区/战斗场景/微小提琴哥/小型音符粒子.tscn").instantiate()
	note.position = self.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)

func _on_free_timeout() -> void:
	self.queue_free()
