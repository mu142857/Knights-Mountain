extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	ani_2D.play("Wink")
	
func process():
	pass

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Wink":
		get_parent().change_state(1)
