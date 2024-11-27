extends Node2D

var load_status = 0
var world_scene
var progress = []

@onready var progress_bar = $ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_scene = "res://Scenes/world.tscn"
	ResourceLoader.load_threaded_request(world_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	load_status = ResourceLoader.load_threaded_get_status(world_scene, progress)
	progress_bar.value = progress[0] * 100
	if load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(world_scene)
		
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
