extends Node2D

@onready var ep: Node2D = $互动点

func _ready() -> void:
	var camera = preload("res://Assets/主角/场景摄像机.tscn").instantiate()
	get_tree().current_scene.add_child(camera)
	var goblin4_test = preload("res://Assets/幻乡/战斗场景/溃军首领/溃军首领.tscn").instantiate()
	summon_monsters(goblin4_test, $"出怪点/出怪点2")
	ep.available = false

func _process(delta: float) -> void:
	find_boss()
	
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


func _on_area_2d_body_entered(body: Node2D) -> void:
	var arr = $Area2D.get_overlapping_bodies()
	attack_body(arr, 1000)
	
func attack_body(arr: Array, damage: float):
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(damage)

func preloading_resources_kuijunshouling():
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/弹射水晶.tscn")
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子掉落水晶.tscn")
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子水晶爆炸粒子.tscn")
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子激光粒子.tscn")
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子眼泪.tscn")
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子激光.tscn")
	preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子激光瞄准线.tscn")

func find_boss():
	var cld: Array = get_children()
	for i in cld:
		if i.is_in_group("monster"):
			ep.available = false
			return
	ep.available = true
