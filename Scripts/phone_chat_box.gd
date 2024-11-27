extends Control
@onready var full_text = ''
@onready var current_text = ' '
@onready var timer = .04
@onready var timer_max = .04
@onready var label = $PanelContainer/MarginContainer/Label
@onready var isDone = true
@onready var index = 0
@onready var text_array = []
@onready var prompt = $prompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Click"):
		delta = delta*3
	
	timer -= delta 
	if timer < 0:
		if len(current_text) < len(full_text):
			isDone = false
			current_text += full_text[len(current_text)]
			prompt.visible = false
		else:
			isDone = true
			prompt.visible = true
		timer = timer_max
		label.text = current_text
	
	if isDone == true and Input.is_action_just_pressed("Click"):
		if index < len(text_array) - 1:
			index += 1
			display_text(text_array[index])
		else:
			self.visible = false
			Global.text_finished.emit()

func set_text(array):
	index = 0
	text_array = array
	display_text(text_array[index])
	self.visible = true

func display_text(text):
	current_text = ''
	full_text = text
