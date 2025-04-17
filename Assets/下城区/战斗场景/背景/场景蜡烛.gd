extends Light2D

@export var base_color: Color = Color(1, 0.8, 0.7, 1)
@export var min_energy: float = 5
@export var max_energy: float = 20

# 蜡烛是否变暗
var energy_is_fading: bool = true

# 蜡烛颜色变化
var r_is_fading: bool = true

func _ready() -> void:
	randomize()
	color = base_color
	var rand_energy = randf_range(min_energy, max_energy)
	energy = rand_energy

func _process(delta: float) -> void:

	# —— 进行一次随机更新 ——  
	energy_cycle()  
	colour_cycle()                   

func energy_cycle():
	if energy >= max_energy:
		energy = max_energy
		energy_is_fading = true
	elif energy <= min_energy:
		energy = min_energy
		energy_is_fading = false
	
	if !energy_is_fading:
		energy += randf_range(-0.1, 0.25)
	elif energy_is_fading:
		energy -= randf_range(-0.1, 0.25)
		
func colour_cycle():
	if color.r >= 1.1:
		color.r = 1.1
		r_is_fading = true
	elif color.r <= 0.9:
		color.r = 0.9
		r_is_fading = false
			
	if !r_is_fading:
		color.r += randf_range(0, 0.005)
	elif r_is_fading:
		color.r -= randf_range(0, 0.005)
		
