extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attacks: Node2D = $"../../AttackChecks"
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var gpu_particles_2d: GPUParticles2D = $"../../GPUParticles2D"

func enter():
	ani_2D.play("Fall")
	gpu_particles_2d.emitting = true
	$InvisibleTime.start(7)

func process():
	if !monster.is_on_floor():
		ani_2D.play("Fall")
		monster.move_and_slide()

func _on_invisible_time_timeout() -> void:
	get_parent().change_state(6)
