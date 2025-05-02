extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var world: WorldEnvironment = $"../../WorldEnvironment"

func enter():
	#Game.shake_camera(30)
	#Game.flash(1.1, Color(0.6, 0.6, 0.6))
	ani_2D.play("Idle")
	
	monster.modulate.a = 1.0
	world.environment.adjustment_contrast = 1.0
	world.environment.adjustment_saturation = 1.0
	
	var expl = preload("res://Assets/下城区/战斗场景/残灯棋鬼/消失.tscn").instantiate()
	expl.position = monster.global_position - Vector2(0, 200)
	expl.emitting = true
	get_tree().current_scene.add_child(expl)


func process():
	if monster.modulate.a <= 0:
		monster.hide()
		
		if world.environment.adjustment_contrast > 1:
			world.environment.adjustment_contrast -= 0.001
			world.environment.adjustment_saturation -= 0.01
			
		else:
			world.environment.adjustment_contrast = 1.0
			world.environment.adjustment_saturation = 1.0
			
		return
		
	world.environment.adjustment_contrast += 0.01
	monster.modulate.a -= 0.05
	world.environment.adjustment_saturation += 0.1
	


func exit():
	pass
