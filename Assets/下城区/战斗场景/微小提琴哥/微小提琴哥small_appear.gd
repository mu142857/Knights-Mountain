extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围
@onready var backline: Line2D = $"../../Node/Line2D"

func enter():
	backline.is_spawn = true
	ani_2D.play("SmallAppear")

func exit():
	backline.is_spawn = false
	
func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "SmallAppear":
		get_parent().change_state(0)
