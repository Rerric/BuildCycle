extends Node2D

func _input(_event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Hex_Grid.tscn")
