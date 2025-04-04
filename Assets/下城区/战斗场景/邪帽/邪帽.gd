extends CharacterBody2D # 奥斯卡画的邪帽

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health: float = 2000
var ready_to_underground_fire: bool = false
var direct = Vector2.LEFT

@onready var detection_range: Area2D = $PlayerCheck  # 玩家检测区域
var archery_duration: float = 2

func _ready() -> void:
	add_to_group("pagan")
	add_to_group("monster")
	$StateMachine.change_state(0)
	$ArrowTimer.start(3)

func take_hit(value: int):
	
	if $AnimatedSprite2D.animation == "Idle" and health >= 1990:
		$StateMachine.change_state(2)
		health -= value
	elif health <= 0 and $AnimatedSprite2D.animation != "Disappear":
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(8)
	elif $AnimatedSprite2D.animation != "Disappear":
		health -= value
		$HitEffectPlayer.play("HitFlash")
		
func _physics_process(delta: float) -> void:
	#print($AnimatedSprite2D.animation)
	#print(health)
	pass

func _on_arrow_timer_timeout() -> void:
	var arr: Array = detection_range.get_overlapping_bodies()
	if arr.size() > 0:
		for i in arr:
			if i.is_in_group("player"):
				if self.health <=1999:
					archery(i)
	$ArrowTimer.start(archery_duration)

func archery(player):
	
	var sce1 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce2 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce3 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce4 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce5 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce6 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce7 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	var sce8 = preload("res://Assets/下城区/战斗场景/邪帽/火矢.tscn").instantiate()
	
	if self.health >= 1500:
		archery_duration = 2.4
		
		var x1 = player.global_position.x + 65
		var x2 = player.global_position.x - 65
		sce1.global_position = Vector2(x1, 60)
		self.get_parent().add_child(sce1)
		sce2.global_position = Vector2(x2, 60)
		self.get_parent().add_child(sce2)
		
	elif self.health >= 1000:
		archery_duration = 3
		
		var x1 = player.global_position.x + 80
		var x2 = player.global_position.x - 80
		var x3 = player.global_position.x + 120
		var x4 = player.global_position.x - 120
		sce3.global_position = Vector2(x1, 60)
		self.get_parent().add_child(sce3)
		sce4.global_position = Vector2(x2, 60)
		self.get_parent().add_child(sce4)
		sce5.global_position = Vector2(x3, 60)
		self.get_parent().add_child(sce5)
		sce6.global_position = Vector2(x4, 60)
		self.get_parent().add_child(sce6)
		
	elif self.health >= 500:
		archery_duration = 4.2

		var x1 = player.global_position.x + 90
		var x2 = player.global_position.x - 90
		var x3 = player.global_position.x + 240
		var x4 = player.global_position.x - 240
		var x5 = player.global_position.x + 280
		var x6 = player.global_position.x - 280
		sce3.global_position = Vector2(x1, 60)
		self.get_parent().add_child(sce3)
		sce4.global_position = Vector2(x2, 60)
		self.get_parent().add_child(sce4)
		sce5.global_position = Vector2(x3, 60)
		self.get_parent().add_child(sce5)
		sce6.global_position = Vector2(x4, 60)
		self.get_parent().add_child(sce6)
		sce7.global_position = Vector2(x5, 60)
		self.get_parent().add_child(sce7)
		sce8.global_position = Vector2(x6, 60)
		self.get_parent().add_child(sce8)
		
	elif self.health >= 0:
		archery_duration = 4.4

		var x1 = player.global_position.x + 160
		var x2 = player.global_position.x - 160
		var x3 = player.global_position.x + 200
		var x4 = player.global_position.x - 200
		var x5 = player.global_position.x + 240
		var x6 = player.global_position.x - 240
		var x7 = player.global_position.x + 280
		var x8 = player.global_position.x - 280
		sce1.global_position = Vector2(x1, 60)
		self.get_parent().add_child(sce1)
		sce2.global_position = Vector2(x2, 60)
		self.get_parent().add_child(sce2)
		sce3.global_position = Vector2(x3, 65)
		self.get_parent().add_child(sce3)
		sce4.global_position = Vector2(x4, 65)
		self.get_parent().add_child(sce4)
		sce5.global_position = Vector2(x5, 70)
		self.get_parent().add_child(sce5)
		sce6.global_position = Vector2(x6, 70)
		self.get_parent().add_child(sce6)
		sce7.global_position = Vector2(x7, 75)
		self.get_parent().add_child(sce7)
		sce8.global_position = Vector2(x8, 75)
		self.get_parent().add_child(sce8)
		pass
