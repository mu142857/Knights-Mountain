extends Area2D

var note_duration: String
var damage: bool
var top_or_bot: String

func _ready() -> void:
	$AnimatedSprite2D.modulate.a = 1
	$AnimatedSprite2D.play(note_duration)
	$Disappear.start(2)
	$Middle.start(1)
	shift()
	if damage == true:
		attack(note_duration)

func shift():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(700, self.global_position.y), 1) 

func _on_middle_timeout() -> void:
	play_note()
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(0, self.global_position.y), 1) 

func _on_disappear_timeout() -> void:
	self.queue_free()

func play_note():
	$AnimatedSprite2D.modulate.a = 0.5
	var note = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/流动音符播放粒子.tscn").instantiate()
	note.position = self.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)

func attack(dura: String):
	if top_or_bot == "top":
		var att = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/上方伤害音符.tscn").instantiate()
		att.global_position = self.global_position
		if dura == "1.0":
			att.is_hole = true
		get_tree().current_scene.add_child(att)
	else:
		var att = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/下方伤害音符.tscn").instantiate()
		att.global_position = self.global_position
		if dura == "1.0":
			att.is_hole = true
		get_tree().current_scene.add_child(att)
