extends Node2D

func _ready() -> void:
	#var mao = preload("res://Assets/幽盲区/战斗场景/栗子劫念/栗子劫念.tscn").instantiate()
	#var mao = preload("res://Assets/幻乡/战斗场景/封尘的噬咒碑/封尘的石刻.tscn").instantiate()
	#summon_monsters(mao, $"出怪点1")
	#var zj = preload("res://Assets/主角/战斗主角.tscn").instantiate()
	#summon_monsters(zj, $"主角生成点")
	pass

func _process(delta: float) -> void:
	pass
	
func summon_monsters(instant, summon_pisition: Node2D):
	instant.position = summon_pisition.global_position
	#instant.scene_startx = 0
	#instant.scene_endx = 1400d
	add_child(instant)
