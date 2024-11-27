extends Node2D

@onready var progress_bar = $ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	load_progress_bar()
	
func load_progress_bar():
	
	var fraction = Global.progress / Global.progress_max
	progress_bar.value = fraction * progress_bar.max_value
	print('Fraction '+str(fraction))
	
	print('Progress '+str(Global.progress))
	print('Progress Max '+str(Global.progress_max))
	print('Value '+str(progress_bar.value))
