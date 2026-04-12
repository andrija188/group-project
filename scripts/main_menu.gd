extends Node2D

@onready var animation = $AnimationPlayer

func _on_play_pressed() -> void:
	animation.play("fade_in")
	Trans.change_scene("res://scenes/screen2.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	animation.play("fade_in")
	Trans.change_scene("res://scenes/settings.tscn")
