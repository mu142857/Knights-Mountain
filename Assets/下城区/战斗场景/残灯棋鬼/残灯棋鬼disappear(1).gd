extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var world: WorldEnvironment = Game.get_node("WorldEnvironment")
@onready var detection_range: Area2D = $"../../MonsterCheck" # 寻找玩家的范围

var summoned_monster_exist: bool = true
var ready_to_change_state: bool = false
func enter():
	ready_to_change_state = false
	
	$HidenTimer.start(2.5)
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	ani_2D.play("Idle")
	
	monster.modulate.a = 1.0
	world.environment.adjustment_contrast = 1.0
	world.environment.adjustment_saturation = 1.0
	
	var explo = preload("res://Assets/下城区/战斗场景/残灯棋鬼/消失.tscn").instantiate()
	explo.position = monster.global_position - Vector2(0, 200)
	explo.emitting = true
	get_tree().current_scene.add_child(explo)


func process():
	get_tatterer_info()
	
	if ready_to_change_state == true and summoned_monster_exist == false:
		get_parent().change_state(2)
		return

	if monster.modulate.a <= 0:
		monster.global_position.y = 0
		if world.environment.adjustment_contrast > 1:
			world.environment.adjustment_contrast -= 0.002
			world.environment.adjustment_saturation -= 0.02
			
		else:
			world.environment.adjustment_contrast = 1.0
			world.environment.adjustment_saturation = 1.0
			
		return
		
	world.environment.adjustment_contrast += 0.02
	monster.modulate.a -= 0.05
	world.environment.adjustment_saturation += 0.2

func exit():
	monster.modulate.a = 0.0
	world.environment.adjustment_contrast = 1.0
	world.environment.adjustment_saturation = 1.0

func _on_hiden_timer_timeout() -> void:
	ready_to_change_state = true

func get_tatterer_info() -> void:
	
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("tatterer"):
				summoned_monster_exist = true
				return
		summoned_monster_exist = false
	summoned_monster_exist = false
