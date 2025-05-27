extends Node2D

func _ready() -> void:
	pass
	

func _process(delta: float) -> void:
	pass
	
func summon_monsters(instant, summon_pisition: Node2D):
	instant.position = summon_pisition.global_position
	instant.scene_startx = 450.0
	instant.scene_endx = 1400.0
	add_child(instant)


func _on_timer_timeout() -> void:
	#var goblin_test = preload("res://Assets/幻乡/战斗场景/哥布林回旋镖兵/哥布林回旋镖兵.tscn").instantiate()
	#summon_monsters(goblin_test, $"出怪点/出怪点1")
	#var goblin1_test = preload("res://Assets/幻乡/战斗场景/哥布林刀兵/哥布林刀兵.tscn").instantiate()
	#summon_monsters(goblin1_test, $"出怪点/出怪点1")
	#var goblin2_test = preload("res://Assets/幻乡/战斗场景/哥布林矛兵/哥布林矛兵.tscn").instantiate()
	#summon_monsters(goblin2_test, $"出怪点/出怪点1")
	#var goblin3_test = preload("res://Assets/幻乡/战斗场景/哥布林火焰兵/哥布林火焰兵.tscn").instantiate()
	#summon_monsters(goblin3_test, $"出怪点/出怪点1")
	var goblin4_test = preload("res://Assets/幻乡/战斗场景/溃军首领/溃军首领.tscn").instantiate()
	summon_monsters(goblin4_test, $"出怪点/出怪点2")
	#var mao = preload("res://Assets/下城区/战斗场景/邪帽/邪帽.tscn").instantiate()
	#summon_monsters(mao, $"出怪点/出怪点2")
	$Timer.start(3000)


func _on_area_2d_body_entered(body: Node2D) -> void:
	var arr = $Area2D.get_overlapping_bodies()
	attack_body(arr, 1000)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)
