extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck"

func enter():
	ani_2D.play("Crystallization")

func process():
	pass

func exit():
	pass
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Crystallization":
		monster.hide()
		var goblin1_1 = preload("res://Assets/幻乡/战斗场景/哥布林刀兵/哥布林刀兵.tscn").instantiate()
		var goblin2_1 = preload("res://Assets/幻乡/战斗场景/哥布林回旋镖兵/哥布林回旋镖兵.tscn").instantiate()
		var goblin1_2 = preload("res://Assets/幻乡/战斗场景/哥布林刀兵/哥布林刀兵.tscn").instantiate()
		var goblin2_2 = preload("res://Assets/幻乡/战斗场景/哥布林回旋镖兵/哥布林回旋镖兵.tscn").instantiate()
		var goblin3 = preload("res://Assets/幻乡/战斗场景/哥布林矛兵/哥布林矛兵.tscn").instantiate()
		var goblin4 = preload("res://Assets/幻乡/战斗场景/哥布林火焰兵/哥布林火焰兵.tscn").instantiate()
		if monster.health >= 1400:
			teloport(5, [goblin1_1, goblin2_1, goblin1_2, goblin2_2])
		elif monster.health >= 700:
			teloport((monster.health / 300) + 4, [goblin1_1, goblin2_1, goblin3, goblin2_2])
		else:
			teloport((monster.health / 200) + 5, [goblin1_1, goblin2_1, goblin3, goblin4])

func teloport(duration: float, summon: Array):
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				monster.global_position.x = i.global_position.x
	monster.global_position.y = -100

	for j in summon:
		summon_monsters(j)
	$Timer.start(duration)
				
func summon_monsters(instant):
	instant.position.x = randf_range(monster.scene_startx + 20, monster.scene_endx - 40)
	instant.position.y = 0
	instant.scene_startx = monster.scene_startx
	instant.scene_endx = monster.scene_endx
	monster.get_parent().add_child(instant)

func _on_timer_timeout() -> void:
	monster.show()
	get_parent().change_state(6)
