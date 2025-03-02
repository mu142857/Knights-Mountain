extends Basic_State

var speed: float = 100
@onready var player: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	speed = 400
	$"../../AnimationPlayer".play("Attack1")
	
func attack1_1_check():
	var arr1: Array = []
	arr1 = $"../../AttackChecks/Attack1-1".get_overlapping_bodies()
	for i in arr1:
		if i.is_in_group("monster"):
			knife_light()
			Game.shake_camera(3)
			Game.flash(0.8, Color(1, 0.5, 0.8))
			i.take_hit(20)

func attack1_2_check():
	var arr2: Array = [] #,,
	arr2 = $"../../AttackChecks/Attack1-1".get_overlapping_bodies()
	for i in arr2:
		if i.is_in_group("monster"):
			knife_light()
			Game.shake_camera(3)
			Game.flash(0.8, Color(0.8, 0.5, 1))
			i.take_hit(30)

	
func process():
	
	var vec: Vector2 = Vector2.ZERO
	vec.x = Input.get_axis("horizontal_left", "horizontal_right")
	if vec.x == 0:
		pass
	elif vec.x > 0:
		ani_sprite2d.scale.x = 1
		$"../../AttackChecks".scale.x = 1
	else:
		ani_sprite2d.scale.x = -1
		$"../../AttackChecks".scale.x = -1
		
	if Input.is_action_just_pressed("horizontal_jump") and $"../Jump".ready_to_jump:
		get_parent().change_state(4)
		return
	elif Input.is_action_just_pressed("horizontal_sprint") and $"../Sprint".ready_to_sprint:
		get_parent().change_state(9)
		return
		
	player.velocity = speed * vec
	player.velocity.y = 1
	player.move_and_slide() 
	
func exit():
	$"../../AnimationPlayer".stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Attack1":
		get_parent().change_state(0)
		
func knife_light():
	var afterimage = preload("res://Assets/主角/刀光.tscn").instantiate()
	afterimage.scl = Vector2(1.6, 1.4)
	afterimage.global_position = $"../../AttackChecks/KnifeLightPoint".global_position
	afterimage.rotation_degrees = randf_range(0, 360)
	player.get_parent().add_child(afterimage)
