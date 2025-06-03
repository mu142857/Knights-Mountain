extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var ami_plr: AnimationPlayer = $"../../AnimationPlayer"
@onready var monster: CharacterBody2D = $"../.."
@onready var gpu_particles_2d: GPUParticles2D = $"../../GPUParticles2D"


func enter():
	attack_check()
	Game.shake_camera(30)
	Game.flash(0.5, Color(0.243, 0.145, 0.184, 0.3))
	ami_plr.play("Trampling")
	gpu_particles_2d.emitting = false

func process():
	pass

func exit():
	ami_plr.stop()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Trampling":
		get_parent().change_state(0)

func attack_check():
	var arr = $"../../AttackChecks/Trampling".get_overlapping_bodies()
	for i in arr:
		if i.is_in_group("player"):
			i.take_hit(15)
