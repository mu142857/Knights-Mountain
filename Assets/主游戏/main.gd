extends Node

func _ready() -> void:
	var title_page = preload("res://Assets/开始界面/标题页面.tscn").instantiate()
	
	add_child(title_page)
