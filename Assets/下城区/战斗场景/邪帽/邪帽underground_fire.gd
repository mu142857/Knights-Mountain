extends Basic_State

@onready var monster: CharacterBody2D = $"../.."
var duration = 0.1
var num = 0

func enter():
	monster.hide()
	
	var wait = monster.health / 40000
	duration = 0.05 + wait
	
	num = 0
	$"../../AnimatedSprite2D".play("GroundFire")
	$Timer.start(duration)
	
func process():
	pass
	
func exit():
	monster.ready_to_underground_fire = false


func _on_timer_timeout() -> void:
	var sce = preload("res://Assets/下城区/战斗场景/邪帽/地火.tscn").instantiate()
	if num <= 11:
		num += 2
		sce.global_position = Vector2(num * 100, 850)
		monster.get_parent().add_child(sce)
		$Timer.start(duration)
	else:
		$End.start(1.15)


func _on_end_timeout() -> void:
	get_parent().change_state(2)
