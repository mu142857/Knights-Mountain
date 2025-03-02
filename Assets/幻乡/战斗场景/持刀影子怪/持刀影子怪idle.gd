extends Basic_State

@onready var shadow: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

var is_ready_to_attack: bool = true

func enter():
	ani_sprite2d.play("Idle")
	
	$"../../Rays/玩家检测射线左".force_raycast_update()
	$"../../Rays/玩家检测射线右".force_raycast_update()
	$"../../Rays/攻击检测射线左".force_raycast_update()
	$"../../Rays/攻击检测射线右".force_raycast_update()

func process():
	if !shadow.is_on_floor():
		shadow.velocity.y += 30
		shadow.move_and_slide() 	
	elif is_ready_to_attack:
		find_player()

func exit():
	pass
	
func find_player():
	
	if is_instance_valid($"../../Rays/攻击检测射线右".get_collider()):
		if $"../../Rays/攻击检测射线右".get_collider().is_in_group("player"):
			get_parent().change_state(4)
			is_ready_to_attack = false
			$Timer.start(1)
			
	elif is_instance_valid($"../../Rays/攻击检测射线左".get_collider()):
		if $"../../Rays/攻击检测射线左".get_collider().is_in_group("player"):
			get_parent().change_state(4)
			is_ready_to_attack = false
			$Timer.start(1)
			
	elif is_instance_valid($"../../Rays/玩家检测射线右".get_collider()):
		if $"../../Rays/玩家检测射线右".get_collider().is_in_group("player"):
			get_parent().change_state(2)
			is_ready_to_attack = false
			$Timer.start(2)
			
	elif is_instance_valid($"../../Rays/玩家检测射线左".get_collider()):
		if $"../../Rays/玩家检测射线左".get_collider().is_in_group("player"):
			get_parent().change_state(2)
			is_ready_to_attack = false
			$Timer.start(2)

func _on_timer_timeout() -> void:
	is_ready_to_attack = true
