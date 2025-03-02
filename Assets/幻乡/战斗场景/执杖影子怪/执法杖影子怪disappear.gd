extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	ani_sprite2d.play("Disappear")

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Disappear":
		teleport()
		get_parent().change_state(1)
		

func teleport():
	shadow.hide()
	if is_instance_valid($"../../Rays/玩家检测射线右".get_collider()):
		var plr = $"../../Rays/玩家检测射线右".get_collider()
		if plr.is_in_group("player"):
			determ_posis(plr)
	elif is_instance_valid($"../../Rays/玩家检测射线左".get_collider()):
		var plr = $"../../Rays/玩家检测射线左".get_collider()
		if plr.is_in_group("player"):
			determ_posis(plr)
		
	else:
		if shadow.global_position.x > pc(1000): # 检测不到玩家, 传送至自己现在位置的另一侧
			shadow.position.x = randf_range(pc(25), pc(225))
			ani_sprite2d.scale.x = -1.52
		else:                                   
			shadow.position.x = randf_range(pc(1175), pc(1375))
			ani_sprite2d.scale.x = 1.52
		
func determ_posis(plr):
	if plr.global_position.x > 800:     # 玩家在右，传送至左
		shadow.position.x = randf_range(pc(25), pc(225))
		ani_sprite2d.scale.x = -1.52
	elif plr.global_position.x < 600:   # 玩家在左，传送至右
		shadow.position.x = randf_range(pc(1175), pc(1375))
		ani_sprite2d.scale.x = 1.52
	else:                               # 玩家居中，传送至自己现在位置的另一侧
		if shadow.global_position.x > pc(1000):
			shadow.position.x = randf_range(pc(25), pc(225))
			ani_sprite2d.scale.x = -1.52
		else:
			shadow.position.x = randf_range(pc(1175), pc(1375))
			ani_sprite2d.scale.x = 1.52

func pc(p): # position calculation, 通过场景大小计算安全位置
	return ((shadow.scene_endx - shadow.scene_startx) / 1400 * p + shadow.scene_startx)
	
