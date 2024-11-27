extends Control

@onready var look_slider = $"MarginContainer/VBoxContainer/Look Slider"
@onready var look_slider_scale = 10000

@onready var mouse_slider = $"MarginContainer/VBoxContainer/Mouse Slider"
@onready var mouse_slider_scale = 10000
@onready var audio_slider = $"MarginContainer/VBoxContainer/Audio Slider"

func _ready():
	look_slider.value = Global.LOOK_SENSITIVITY * look_slider_scale
	mouse_slider.value = Global.MOUSE_SENSITIVITY * mouse_slider_scale
	var index= AudioServer.get_bus_index("Master")
	audio_slider.value = AudioServer.get_bus_volume_db(index)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_look_slider_value_changed(value: float) -> void:
	Global.LOOK_SENSITIVITY = value / look_slider_scale
	print(Global.LOOK_SENSITIVITY)

func _on_mouse_slider_value_changed(value: float) -> void:
	Global.MOUSE_SENSITIVITY = value / mouse_slider_scale
	print(Global.MOUSE_SENSITIVITY)


func _on_audio_slider_value_changed(value: float) -> void:
	var index= AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(index, value)
