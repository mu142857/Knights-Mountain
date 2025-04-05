extends Node2D

func _ready() -> void:
	#var shadow_test = preload("res://Assets/幻乡/战斗场景/执杖影子怪/执法杖影子怪.tscn").instantiate()
	#summon_monsters(shadow_test, $"出怪点1")
	#var goblin_test = preload("res://Assets/幻乡/战斗场景/持刀影子怪/持太刀影子怪.tscn").instantiate()
	#summon_monsters(goblin_test, $"出怪点1")
	#var goblin_test2 = preload("res://Assets/幻乡/战斗场景/哥布林火焰兵/哥布林火焰兵.tscn").instantiate()
	#summon_monsters(goblin_test2, $"出怪点1")
	#var goblin_test3 = preload("res://Assets/幻乡/战斗场景/哥布林回旋镖兵/哥布林回旋镖兵.tscn").instantiate()
	#summon_monsters(goblin_test3, $"出怪点1")
	var mao = preload("res://Assets/下城区/战斗场景/邪帽/邪帽.tscn").instantiate()
	summon_monsters(mao, $"出怪点1")
	

func _process(delta: float) -> void:
	pass
	
func summon_monsters(instant, summon_pisition: Node2D):
	instant.position = summon_pisition.global_position
	instant.scene_startx = 0
	instant.scene_endx = 1400
	add_child(instant)
