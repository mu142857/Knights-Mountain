extends CharacterBody2D

var scene_startx: float = 0.0
var scene_endx: float = 1400.0
var health = 4000
var direct = 1 # 1 = 面向右边， -1 = 面向左边

@export var small_or_big: String = "small"
var real_scale: float = 1.0
func _ready() -> void:
	
	#add_to_group("tatterer")
	add_to_group("monster")
	#$StateMachine.change_state(0)

func take_hit(value: int):
	if health <= 0:
		$HitEffectPlayer.play("HitFlash")
		$StateMachine.change_state(4)

	else:
		health -= value
		$HitEffectPlayer.play("HitFlash")

func _physics_process(delta: float) -> void:
	if small_or_big == "small":
		real_scale = 1.0
	else:
		real_scale = 3.0
	
	self.scale.x = real_scale * direct
	self.scale.y = real_scale
	
func change_scale():
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", 3, 2.875) 
