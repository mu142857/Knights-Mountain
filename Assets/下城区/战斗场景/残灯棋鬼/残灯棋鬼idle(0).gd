extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

@onready var checkerboard_left: CharacterBody2D = $"../../残灯移动棋盘/残灯移动棋盘左"
@onready var checkerboard_right: CharacterBody2D = $"../../残灯移动棋盘/残灯移动棋盘右"

var wait_duration: float = 0.0
var last_venue: int = 0

func enter():
	monster.global_position.y = 850
	find_level()
	find_venue()
	
	if last_venue < monster.venue_level:
		match monster.venue_level:
			0:
				pass
			1:
				checkerboard_left.transition(1)
				checkerboard_right.transition(0)
			2:
				checkerboard_left.transition(0)
				checkerboard_right.transition(1)
			3:
				checkerboard_left.transition(0)
				checkerboard_right.transition(2)
			4:
				checkerboard_left.transition(1)
				checkerboard_right.transition(1)
			5:
				checkerboard_left.transition(2)
				checkerboard_right.transition(1)
			6:
				checkerboard_left.transition(2)
				checkerboard_right.transition(2)
			_:
				pass
	wait_duration = (6 - monster.health_level) / 5
	
	ani_2D.play("Idle")
	$Timer.start(wait_duration)
	
func process():
	pass
	
func _on_timer_timeout() -> void:
	get_parent().change_state(3)

func exit():
	last_venue = monster.venue_level

func find_level(): # 决定boss召唤物
	if monster.health > 3000:
		monster.health_level = 0
	elif monster.health > 2000:
		monster.health_level = 1
	elif monster.health > 1000:
		monster.health_level = 2
	elif monster.health > 0000:
		monster.health_level = 3
	else:
		monster.health_level = 4

func find_venue(): # 决定场景变化
	if monster.health > 3500:
		monster.venue_level = 0
	elif monster.health > 3000:
		monster.venue_level = 1
	elif monster.health > 2500:
		monster.venue_level = 2
	elif monster.health > 2000:
		monster.venue_level = 3
	elif monster.health > 1000:
		monster.venue_level = 4
	elif monster.health > 0500:
		monster.venue_level = 5
	elif monster.health > 0000:
		monster.venue_level = 6
	else:
		monster.venue_level = 7
