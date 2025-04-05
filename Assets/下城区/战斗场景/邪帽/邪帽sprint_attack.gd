extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."

var speed: float = 0.0
var health_stage: int = 1
var last_health_stage: int = 1

func enter():
	#print(health_stage)
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	ani_2D.play("Idle")
	speed = 40 + (2000 - monster.health) / 10
	var initial_health: float = monster.health
	if initial_health > 1600:
		health_stage = 1
	elif initial_health > 1200:
		health_stage = 2
	elif initial_health > 800:
		health_stage = 3
	elif initial_health > 400:
		health_stage = 4
	else:
		health_stage = 5
	$Timer.start(randf_range(0, 0.5))

func process():
	
	if $"../../技能汲取特效".modulate.a > 0.0:
		$"../../技能汲取特效".modulate.a -= 0.03
		
	monster.velocity.x = monster.direct.x * (speed + acc() / 1.3)
	monster.velocity.y += 15
	monster.move_and_slide()
	
	#if abs(monster.global_position.x) > (3 * (monster.scene_endx - monster.scene_startx) / 4 + monster.scene_startx):
	# 屏幕3/4处冲刺结束
	if monster.direct == Vector2.LEFT and monster.global_position.x < (1 * (monster.scene_endx - monster.scene_startx) / 5 + monster.scene_startx):
		enter_enderground_fire_stage()
		get_parent().change_state(0)
	elif monster.direct == Vector2.RIGHT and monster.global_position.x > (4 * (monster.scene_endx - monster.scene_startx) / 5 + monster.scene_startx):
		enter_enderground_fire_stage()
		get_parent().change_state(0)

func exit():
	last_health_stage = health_stage

func acc():
	var diff = ((monster.scene_endx - monster.scene_startx) / 2 + monster.scene_startx)
	return diff - abs(monster.global_position.x - diff)

func enter_enderground_fire_stage():
	if last_health_stage != health_stage:
		monster.ready_to_underground_fire = true
			
func scythe():
	var sce = preload("res://Assets/下城区/战斗场景/邪帽/长镰.tscn").instantiate()
	sce.position = Vector2(0, -50)
	sce.scale = ani_2D.scale / 4
	ani_2D.add_child(sce)

func _on_timer_timeout() -> void:
	scythe()
