extends Basic_State #3

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围extends Node

var lizi = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/神秘文字.tscn")

func enter() -> void:
	ani_2D.play("Digdown")
	
	# 释放粒子
	var note = lizi.instantiate()
	note.position = monster.global_position
	note.emitting = true
	get_tree().current_scene.add_child(note)

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Digdown":
		monster.global_position = Vector2(0, 0)
		if monster.stage <= 1:
			$Timer.start(1.5)
		else:
			$Timer.start(0.2)
	if ani_2D.animation == "Digup":
		if monster.stage <= 1:
			get_parent().change_state(1)
		else:
			get_parent().change_state(5)

func _on_timer_timeout() -> void:
	new_pos()
	ani_2D.play("Digup")

func new_pos():
	var new_pos: Vector2 = Vector2(randf_range(300, 1100), 845.997)
	monster.global_position = new_pos
