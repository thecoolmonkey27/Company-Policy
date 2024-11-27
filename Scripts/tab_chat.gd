extends Node2D

@export var max_messages: int = 4  # Limit the number of visible messages
@onready var box_container = $BoxContainer
@onready var rng = RandomNumberGenerator.new()
@onready var scene_message = preload("res://Scenes/Chat/message.tscn")
@onready var v_box_container = $ScrollContainer/VBoxContainer
@onready var scroll_container = $ScrollContainer
@onready var scroll_bar = scroll_container.get_v_scroll_bar()
@onready var LabelOption1 = $LabelOption1
@onready var LabelOption2 = $LabelOption2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_chat_history()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('test'):
		add_message('Test Message', 'right')
		add_message('AAHAH', 'left')
	scroll_container.scroll_vertical = scroll_bar.max_value

# Function to add a left-aligned message (NPC)
func add_message(text, side):
	var instance = scene_message.instantiate()
	instance.text = text
	
	
	if side == 'right':
		instance.layout_direction = 3
	elif side == 'left':
		instance.layout_direction = 2
	v_box_container.add_child(instance)
	var list = [text, side]
	Global.chat_history.append(list)

func add_message_history(text, side):
	var instance = scene_message.instantiate()
	instance.text = text
	
	
	if side == 'right':
		instance.layout_direction = 3
	elif side == 'left':
		instance.layout_direction = 2
	v_box_container.add_child(instance)
	var list = [text, side]

func set_options(options):
	LabelOption1.text = options[0]
	LabelOption2.text = options[1]

func load_chat_history():
	for message in Global.chat_history:
		add_message_history(message[0], message[1])
		print(message)
