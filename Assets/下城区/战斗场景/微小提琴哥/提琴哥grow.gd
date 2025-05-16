extends Basic_State

@onready var ani_2D: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var monster: CharacterBody2D = $"../.."
@onready var detection_range: Area2D = $"../../PlayerCheck" # 寻找玩家的范围

func enter():
	$"../../AnimationPlayer".stop()
	$"../../Node/Line2D".hide()
	ani_2D.play("Gigantic")
	ani_2D_grow()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_2D.animation == "Gigantic":
		monster.scale = Vector2(3, 3)
		monster.small_or_big = "big"
		get_parent().change_state(8)

func ani_2D_grow():
	var tween = create_tween()

	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.set_trans(Tween.TRANS_QUAD)       # 二次缓动曲线（加速—减速）
	tween.set_ease(Tween.EASE_IN_OUT)       # 先加速后减速
	tween.tween_property(monster, "scale", Vector2(3, 3), 2.875)
