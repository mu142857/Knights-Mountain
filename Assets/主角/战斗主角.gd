class_name Player
extends CharacterBody2D

var max_health = 1000
var health: float
var invincible_time: float = 0.3
var invincible: bool = false

func _ready() -> void:
	
	invincible = false
	health = max_health

	self.add_to_group("player")
	#$ShadowCreater.start(1) # 影子
	
	$StatesMachine.change_state(0)

func _on_shadow_creater_timeout() -> void:
	var player_shadow = preload("res://Assets/主角/角色阴影.tscn").instantiate()
	player_shadow.global_position = self.global_position
	get_parent().add_child(player_shadow)
	var cam = preload("res://Assets/主角/场景摄像机.tscn").instantiate()
	get_parent().add_child(cam)

func take_hit(damage: float):

	if !invincible and $AnimatedSprite2D.animation != "Sprint":
		invincible = true
		$InvincibleTime.start(invincible_time)
		$HitEffectPlayer.play("HitFlash")
		Game.filter(1, Color(0.6, 0, 0, 0.9))
		if health > 0:
			health -= damage
		Game.frame_freeze(0.2, invincible_time)

func _process(delta: float) -> void:
	if health <= 0:
		health = 0
		$StatesMachine.change_state(7)
			
func _on_invincible_time_timeout() -> void:
	invincible = false
