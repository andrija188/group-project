extends Node2D

@onready var animation = $AnimationPlayer
@onready var slider = $HSlider

func _on_back_pressed() -> void:
	animation.play("fade_in")
	Trans.change_scene("res://scenes/main_menu.tscn")
