extends Node2D

@onready var tab = $Tab
@onready var ButtonTab1 = $ButtonTab1
@onready var ButtonTab2 = $ButtonTab2
@onready var ButtonTab3 = $ButtonTab3
@onready var ButtonResponse1 = $ButtonResponse1
@onready var ButtonResponse2 = $ButtonResponse2
@onready var SoundClick = $SoundClick
@onready var SoundNotification = $SoundNotification
@onready var ButtonNo = $ButtonNo
@onready var ButtonYes = $ButtonYes


signal button_pressed(button)

var current_layer = []
var buttons_layer1 = []
var buttons_layer2 = []
var buttons_layer3 = []
var tab_chat = preload("res://Scenes/Chat/tab_chat.tscn")
var tab_wheel = preload("res://Scenes/tab_wheel.tscn")
var tab_calendar = preload("res://Scenes/tab_calendar.tscn")
var tab_instance = tab_chat.instantiate()


var ai_timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	buttons_layer1 = {
		"ButtonTab1" : ButtonTab1,
		"ButtonTab2" : ButtonTab2,
		"ButtonTab3" : ButtonTab3,
		"ButtonResponse1" : ButtonResponse1,
		"ButtonResponse2" : ButtonResponse2,
		
	}
	buttons_layer2 = {
		"ButtonNo" : ButtonNo,
		"ButtonYes" : ButtonYes,
		"ButtonTab1" : ButtonTab1,
		"ButtonTab2" : ButtonTab2,
		"ButtonTab3" : ButtonTab3,
	}
	buttons_layer3 = {
		"ButtonTab1" : ButtonTab1,
		"ButtonTab2" : ButtonTab2,
		"ButtonTab3" : ButtonTab3,
	}
	current_layer = buttons_layer1
	switchTab(tab_chat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	checkMousePress()
	
	set_options(Global.options)
	
	ai_timer -= delta


func checkMousePress():
	if Input.is_action_just_released("Click") and Global.isUsingPc and not Global.isPaused:
		SoundClick.play()
		for b in current_layer:
			if Global.mousePosition.x > current_layer[b].position.x:
				if Global.mousePosition.x < current_layer[b].position.x + current_layer[b].scale.x:
					if Global.mousePosition.y > current_layer[b].position.y:
						if Global.mousePosition.y < current_layer[b].position.y + current_layer[b].scale.y:
							button_pressed.emit(b)
							return
							print(b)

func switchTab(tab):
	remove_child(tab_instance)
	tab_instance = tab.instantiate()
	add_child(tab_instance)

func send_message(Text, Side):
	var is_chat = false
	if Side == 'left':
		SoundNotification.play()
	for child in get_children():
		if child.has_method("add_message"):
			child.add_message(Text, Side)
			is_chat = true
	if is_chat == false:
		var list = [Text, Side]
		Global.chat_history.append(list)

func set_options(options):
	for child in get_children():
		if child.has_method("set_options"):
			child.set_options(options)

func load_reports():
	for child in get_children():
		if child.has_method("load_reports"):
			child.load_reports()

func _on_button_pressed(button: Variant) -> void:
	print('button pressed')
	if button == 'ButtonTab1':
		switchTab(tab_chat)
		print('changed scene successfully')
		current_layer = buttons_layer1
	if button == "ButtonTab2":
		switchTab(tab_wheel)
		print('changed scene successfully')
		current_layer = buttons_layer2
	if button == "ButtonTab3":
		switchTab(tab_calendar)
		current_layer = buttons_layer3
	if button == "ButtonResponse1":
		if Global.options[0] != '':
			
			
			send_message(Global.options[0], 'right')
			Global.last_response = Global.options[0]
			Global.message_sent.emit()
	if button == "ButtonResponse2":
		if Global.options[1] != '':
			
			
			send_message(Global.options[1], 'right')
			Global.last_response = Global.options[1]
			Global.message_sent.emit()
	
	if button == "ButtonYes":
		wheel_pressed("yes")
	
	if button == "ButtonNo":
		wheel_pressed('no')
		
func wheel_pressed(input):
	if Global.left_png == Global.right_png and input == 'yes':
		Global.progress += 1
	elif Global.left_png != Global.right_png and input == 'no':
		Global.progress += 1
	else:
		if Global.progress < Global.progress_max:
			Global.progress -= 1
	if Global.progress == Global.progress_max:
		Global.work_completed.emit()
	load_reports()
