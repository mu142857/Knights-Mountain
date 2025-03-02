extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	ani_sprite2d.play("SprintStop")
	if is_instance_valid($"../../Rays/玩家检测射线右".get_collider()):
		var plrr = $"../../Rays/玩家检测射线右".get_collider()
		if plrr.is_in_group("player"):
			ani_sprite2d.scale.x = 1.52
			$"../../AttackChecks".scale.x = -1
			
	if is_instance_valid($"../../Rays/玩家检测射线左".get_collider()):
		var plrl = $"../../Rays/玩家检测射线左".get_collider()
		if plrl.is_in_group("player"):
			ani_sprite2d.scale.x = -1.52
			$"../../AttackChecks".scale.x = 1

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "SprintStop":
		get_parent().change_state(3)
