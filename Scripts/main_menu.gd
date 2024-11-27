extends Control

@onready var transition = $Transition/AnimationPlayer

func _on_play_pressed() -> void:
	
	transition.play("fade_in")
	transition.get_parent().get_node("ColorRect").color.a = 255
	await get_tree().create_timer(.5).timeout
	
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/loading.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
