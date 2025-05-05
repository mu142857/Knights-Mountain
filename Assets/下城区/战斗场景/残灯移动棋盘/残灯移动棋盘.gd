extends CharacterBody2D

var left_or_right: String = "left"

const LEVEL_0_POSITION_LEFT: Vector2 = Vector2(-50, 1060)
const LEVEL_1_POSITION_LEFT: Vector2 = Vector2(250, 1060)
const LEVEL_2_POSITION_LEFT: Vector2 = Vector2(350, 960)
const LEVEL_0_POSITION_RIGHT: Vector2 = Vector2(1450, 1060)
const LEVEL_1_POSITION_RIGHT: Vector2 = Vector2(1150, 1060)
const LEVEL_2_POSITION_RIGHT: Vector2 = Vector2(1050, 960)

@onready var monster: CharacterBody2D = $"../.."
func _ready() -> void:
	
	if left_or_right == "left":
		$".".scale.x = 1
		self.global_position = Vector2(-50, 1060)
	else:
		$".".scale.x = -1
		self.global_position = Vector2(1450, 1060)

func _process(delta: float) -> void:
	
	$"移动粒子".global_position.y = 900
	$"移动粒子".global_position.x = self.global_position.x + (self.scale.x * -180)
	
	if left_or_right == "left":
		$".".scale.x = 1
	else:
		$".".scale.x = -1

func set_postion(level: float):
	if left_or_right == "left":
		pass
	else:
		pass

func transition(level: int) -> void:
	# 根据 level 映射目标坐标
	var target_pos: Vector2
	
	if left_or_right == "left":
		match level:
			0:
				target_pos = LEVEL_0_POSITION_LEFT
				monster.scene_startx = LEVEL_0_POSITION_LEFT.x
			1:
				target_pos = LEVEL_1_POSITION_LEFT
				monster.scene_startx = LEVEL_1_POSITION_LEFT.x
			2:
				target_pos = LEVEL_2_POSITION_LEFT
				monster.scene_startx = LEVEL_2_POSITION_LEFT.x
			_:
				monster.scene_startx = 0
				return
	else:
		match level:
			0:
				target_pos = LEVEL_0_POSITION_RIGHT
				monster.scene_endx = LEVEL_0_POSITION_RIGHT.x
			1:
				target_pos = LEVEL_1_POSITION_RIGHT
				monster.scene_endx = LEVEL_1_POSITION_RIGHT.x
			2:
				target_pos = LEVEL_2_POSITION_RIGHT
				monster.scene_endx = LEVEL_2_POSITION_RIGHT.x
			_:
				monster.scene_endx = 1400
				return

	# 创建一次性 Tween（Godot 4.x 推荐用法）
	var tween = create_tween()  # 或 get_tree().create_tween() :contentReference[oaicite:0]{index=0}

	# 在 1 秒内，将 position 从当前值插值到 target_pos
	tween.tween_property(self, "position", target_pos, 1.0) 
	tween.set_trans(Tween.TRANS_QUAD)       # 二次缓动曲线（加速—减速） :contentReference[oaicite:1]{index=1}
	tween.set_ease(Tween.EASE_IN_OUT)       # 先加速后减速 :contentReference[oaicite:2]{index=2}
