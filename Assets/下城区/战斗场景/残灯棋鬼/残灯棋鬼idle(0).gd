extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var r_change: bool = false
var wait_duration: float = 0.0
var last_level: int = 0.0

func enter():
	find_level()
	
	wait_duration = (21 - monster.health_level) / 3.5
	
	ani_2D.play("Idle")
	$Timer.start(wait_duration)
	
func process():
	pass
	
func _on_timer_timeout() -> void:
	if last_level < monster.health_level:
		get_parent().change_state(5)
		r_change = true
	else:
		get_parent().change_state(3)

func exit():
	last_level = monster.health_level

func find_level():
	if monster.health > 3500:
		monster.health_level = 0
	elif monster.health > 3000:
		monster.health_level = 1
	elif monster.health > 2500:
		monster.health_level = 2
	elif monster.health > 2000:
		monster.health_level = 3
	elif monster.health > 1500:
		monster.health_level = 4
	elif monster.health > 1000:
		monster.health_level = 5
	elif monster.health > 500:
		monster.health_level = 6
	elif monster.health > 0:
		monster.health_level = 7
	else:
		monster.health_level = 8
