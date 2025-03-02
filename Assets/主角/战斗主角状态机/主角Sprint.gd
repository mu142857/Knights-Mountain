extends Basic_State

var speed: float = 1000
var is_sprinting: bool = false
var ready_to_sprint: bool = true
@onready var player: CharacterBody2D = $"../.."
@onready var ani_sprite2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	if ready_to_sprint:
		is_sprinting = true
		ready_to_sprint = false
		$Timer.start(0.8)
		ani_sprite2d.play("Sprint")

func process():
	afterimage()
	if ani_sprite2d.scale.x == 1:
		player.velocity.x = speed
	else:
		player.velocity.x = -speed
	player.move_and_slide() 

func exit():
	is_sprinting = false

func _on_timer_timeout() -> void:
	ready_to_sprint = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if ani_sprite2d.animation == "Sprint":
		get_parent().change_state(0)

func afterimage():
	var afterimage = preload("res://Assets/主角/主角冲刺残影.tscn").instantiate()
	afterimage.scl = ani_sprite2d.scale
	afterimage.global_position = player.global_position
	player.get_parent().add_child(afterimage)
