extends Node2D

@onready var anim = $AnimationPlayer

func _on_back_pressed() -> void:
	anim.play("fade_in")
	Trans.change_scene("res://scenes/main_menu.tscn")
