extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

@onready var ani_player: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	ani_player.play("Attack2")

func process():
	pass

func exit():
	ani_player.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Attack2":
		monster.position = Vector2(0, -500)
		get_parent().change_state(1)
