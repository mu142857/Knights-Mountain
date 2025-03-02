extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var attack_range: Area2D = $"../../Attack Check"

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 2.0

func enter():
	ani_2D.play("Hit")

func process():
	monster.velocity = monster.direct * SPEED
	monster.velocity.y = gravity
	monster.move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Hit":
		if monster.direct == Vector2.RIGHT:
			monster.direct = Vector2.LEFT
			ani_2D.scale.x = -1.84
			attack_range.scale.x = -1
		elif monster.direct == Vector2.LEFT:
			monster.direct = Vector2.RIGHT
			ani_2D.scale.x = 1.84
			attack_range.scale.x = 1
		$AttackCountdown.start(2)
		$"../Run".ready_to_attack = false
		get_parent().change_state(0)
		
func exit():
	pass

func _on_attack_countdown_timeout() -> void:
	$"../Run".ready_to_attack = true
