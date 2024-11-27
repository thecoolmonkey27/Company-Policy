extends Node2D

@onready var rng = RandomNumberGenerator.new()
@onready var left = $left
@onready var right = $right
@onready var report_array = [
	"res://Sprites/reports/1.png",
	"res://Sprites/reports/2.png",
	"res://Sprites/reports/3.png",
	"res://Sprites/reports/4.png",
	"res://Sprites/reports/5.png",
	"res://Sprites/reports/6.png",
]

@onready var timer = 5
@onready var timerMax = 5
@onready var progress_bar = $ProgressBar
@onready var isSame = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.left_png == '' and Global.right_png ==  '':
		load_reports()
	load_progress_bar()


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
	
	

func load_reports():
	print('loaded reports')
	var pick = rng.randi_range(1,2)
	if pick == 1:
		var report_png = report_array[rng.randi_range(0, len(report_array))-1]
		
		Global.left_png = report_png
		Global.right_png = report_png
		
		left.texture = load(report_png)
		right.texture = load(report_png)
		left.rotation = rng.randf_range(0,4)*90
		right.rotation = rng.randf_range(0,4)*90
	else:
		var report_png = report_array[rng.randi_range(0, len(report_array))-1]
		Global.left_png = report_png
		left.texture = load(report_png)
		left.rotation = rng.randf_range(0,4)*90
		
		report_png = report_array[rng.randi_range(0, len(report_array))-1]
		Global.right_png = report_png
		right.texture = load(report_png)
		right.rotation = rng.randf_range(0,4)*90
