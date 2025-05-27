extends Node2D

func _ready() -> void:
	var zj = preload("res://Assets/主角/战斗主角.tscn").instantiate()
	summon_monsters(zj, $"主角生成点")

	$Timer.start(2)

func _process(delta: float) -> void:
	pass
	
func summon_monsters(instant, summon_pisition: Node2D):
	instant.position = summon_pisition.global_position
	#instant.scene_startx = 0
	#instant.scene_endx = 1400
	add_child(instant)


func _on_timer_timeout() -> void:
	#var tqg = preload("res://Assets/下城区/战斗场景/残灯主教/残灯主教.tscn").instantiate()
	var tqg = preload("res://Assets/下城区/战斗场景/微小提琴哥/微小提琴哥.tscn").instantiate()
	#var tqg = preload("res://Assets/幽盲区/战斗场景/幽居提琴哥/幽居提琴哥.tscn").instantiate()
	summon_monsters(tqg, $"提琴哥生成点")
