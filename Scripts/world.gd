extends Node3D

@onready var pause_scene = preload("res://Scenes/pause.tscn")
@onready var pause_instance = pause_scene.instantiate()
@onready var transition = $transition/AnimationPlayer
@onready var sound_ringing = $PhoneRing
@onready var sound_vent = $Vent
@onready var sound_ambience = $Ambience
@onready var phone_chat_box = $PhoneChatBox
@onready var screen = $PC/screen
@onready var tab_chat = preload("res://Scenes/Chat/tab_chat.tscn")

@onready var level_1 = preload("res://Scenes/level_1.tscn")
@onready var level_1_instance = level_1.instantiate()
@onready var player = $Player
@onready var camera = player.get_child(1)
@onready var vignette = $Shaders/CanvasLayer/Vignette

@onready var Floor2 = $Room/Floor2
@onready var Floor = $Room/Floor
@onready var Floor3 = $Room/Floor3
@onready var Floor4 = $Room/Floor4
@onready var Floor5 = $Room/Floor5
@onready var Floor6 = $Room/Floor6
@onready var Chair = $Room/Chair_Office_Olive
@onready var Mouse = $Room/CompterMouseRounded
@onready var Keyboard = $Room/ComputerKeyboard
@onready var Phone = $"Room/1333Phone"
@onready var Desk = $Room/Desk_Corner_Booth_A
@onready var PC = $PC


@onready var starting_text = [
	'Welcome to Big Corp!', 
	'We are a multimillion dollar company specializing in being productive!', 
	'Thank you for working at our company.',
	'You have been provided with a PC and an office all to yourself.',
	'Use the PC to finish your quota for the day!',
	'You will be able to ask any questions through the built in messaging software.',
	'Good Luck!']

@onready var current_text = ''
@onready var day_caption = $DayCaption

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.get_parent().get_node("ColorRect").color.a = 255
	transition.play("fade_out")
	Global.options = ['', '']
	
	await get_tree().create_timer(5.0).timeout
	Global.isPhoneRinging = true
	current_text = starting_text
	await Global.text_finished
	Global.canUsePc = true
	await Global.interacted_with_pc
	screen.change_level(level_1_instance)
	await get_tree().create_timer(6.0).timeout
	send_message('Hey! Nice Job logging in.', 'left')
	await get_tree().create_timer(3).timeout
	
	send_message('If you have any questions just let me know.', 'left')
	
	set_options("Yeah there is one...", 'Nope! All good here.')
	await Global.message_sent
	set_options('', '')
	if Global.last_response == "Yeah there is one...":
		await get_tree().create_timer(4.0).timeout
		send_message("Sure ask away!",  'left')
		
		set_options("What exactly are we working on?", "Nevermind.")
		await Global.message_sent
		set_options('', '')
		await get_tree().create_timer(5.0).timeout
		send_message("Here at big corp we have a strict Company Policy", 'left')
		await get_tree().create_timer(5.0).timeout
		send_message("Due to our confidentiality regulations we cannot disclose the nature of our projects to new recruits. I hope you understand.", 'left')
		await get_tree().create_timer(6.0).timeout
		send_message("Now get to work.", 'left')
	
	await get_tree().create_timer(3.0).timeout
	
	send_message("Today you'll be verifying reports", 'left')
	await get_tree().create_timer(3.0).timeout
	send_message("If the reports match click the checkmark", "left")
	await get_tree().create_timer(2.0).timeout
	send_message('You can start now.', 'left')
	await get_tree().create_timer(3).timeout
	send_message('Click the tab up at the top.', 'left')
	await get_tree().create_timer(4).timeout
	
	await Global.work_completed
	await get_tree().create_timer(2).timeout
	
	Global.isPhoneRinging = true
	current_text = [
		'Nice job, you made good time.',
		'You are proving to be a valuable asset to our team.',
		'Now, get some sleep. You have another big day tomorrow!'
	]
	await Global.text_finished
	await get_tree().create_timer(2).timeout
	transition.play("fade_in")
	await get_tree().create_timer(1).timeout
	day_caption.text = 'Day  2'
	day_caption.visible = true
	Global.level = 2
	Global.canUsePc = false
	Global.progress = 0
	player.stopUsingPC()
	screen.level_parent.get_child(0).switchTab(tab_chat)
	await get_tree().create_timer(6).timeout
	transition.play("fade_out")
	day_caption.visible = false
	Global.canUsePc = false

	await get_tree().create_timer(4).timeout
	Global.isPhoneRinging = true
	current_text = [
		"Hey, you're still here.",
		"Don't go anywhere!",
		"You have a long day ahead of you...",
		"Let's continue this conversation on your PC."
	]
	await Global.text_finished
	Global.canUsePc = true
	Global.progress = 0 
	await Global.interacted_with_pc
	await get_tree().create_timer(2).timeout
	
	send_message('Lots of work today, you better get on it.', 'left')
	set_options('Where am I?', 'Ok, on it.')
	await Global.message_sent
	set_options('', '')
	if Global.last_response == "Where am I?":
		await get_tree().create_timer(4.0).timeout
		send_message("You're in your office of course!",  'left')
		set_options('Where is the office...', 'Oh that makes sense')
		await Global.message_sent
		set_options('', '')
		if Global.last_response == 'Where is the office...':
			await get_tree().create_timer(4.0).timeout
			send_message("All you need to know is that you are here to work.", 'left')
			await get_tree().create_timer(4.0).timeout
			send_message("Stop asking questions.", 'left')
			set_options('I want to leave.', "Ok, I'll get on it")
			await Global.message_sent
			set_options('', '')
			if Global.last_response == 'I want to leave.':
				sound_ambience.play()
				await get_tree().create_timer(6.0).timeout
				send_message('NO.', 'left')
				await get_tree().create_timer(2.0).timeout
				send_message('We must remain productive', 'left')
				await get_tree().create_timer(4.0).timeout
				send_message('There will be NO TOLERANCE for failure to complete your assigned tasks', 'left')
	
	await get_tree().create_timer(4.0).timeout
	send_message('You know the drill!', 'left')
	await get_tree().create_timer(4.0).timeout
	send_message("Today you'll be sorting emails.", 'left')
	await get_tree().create_timer(2.0).timeout
	send_message("Good Luck.", 'left')
	
	await Global.work_completed
	await get_tree().create_timer(2.0).timeout
	Global.isPhoneRinging = true
	current_text = [
		"Good work today.",
		"I have something special planned for you tomorrow.",
	]
	await Global.text_finished
	
	await get_tree().create_timer(4.0).timeout
	
	transition.play("fade_in")
	await get_tree().create_timer(1).timeout
	day_caption.text = 'Day  3'
	day_caption.visible = true
	Global.level = 3
	Global.progress = 0
	Global.canUsePc = false
	player.stopUsingPC()
	screen.level_parent.get_child(0).switchTab(tab_chat)
	await get_tree().create_timer(6).timeout
	transition.play("fade_out")
	day_caption.visible = false
	Global.canUsePc = true
	
	await get_tree().create_timer(3).timeout
	send_message('Good Morning, I have big news.', 'left')
	await get_tree().create_timer(4).timeout
	send_message('You are getting a promotion!', 'left')
	await get_tree().create_timer(6).timeout
	send_message('And with your promotion you are getting a new job description.', 'left')
	await get_tree().create_timer(6).timeout
	send_message('Instead of working on your meaningless tasks you are finally ready for the real work.', 'left')
	await get_tree().create_timer(4).timeout
	send_message("I can finally tell you what we work on here.", 'left')
	await get_tree().create_timer(4).timeout
	send_message("Here at big corp...", 'left')
	await get_tree().create_timer(5).timeout
	send_message("We make games", 'left')
	await get_tree().create_timer(5).timeout
	send_message("And now you are finally qualified enough to publish titles", 'left')
	await get_tree().create_timer(6).timeout
	send_message("Now, get to work.", 'left')
	
	await Global.work_completed
	await get_tree().create_timer(3).timeout
	
	Global.isPhoneRinging = true
	current_text = [
		"You did it, you completed your task.",
		"All for me...",
		"You did my work without hesitation.",
		"A true follower. I knew I could rely on you.",
		"You did your work flawlessly...",
		"It's too bad it all has to go to waste.",
		"Its too bad...",
		"YOU, have to go to waste",
		"Now I can let you in on my little secret...",
		"You're in a game.",
		"That's right, this job, these quotas. They are all just a game.",
		"You were created by a game, you are in a game, and you are making more games.",
		"Your only purpose is to create more of yourself",
		'''"Interpretation can be put upon them but because they are useful.\n
		When they become so derivative as to become unintelligible,\n
		The same thing may be said for all of us,\n\n
		That we do not admire what we cannot understand."'''
		
	]
	await Global.text_finished
	await get_tree().create_timer(3).timeout
	
	sound_vent.stop()
	Floor.visible = false
	await get_tree().create_timer(1).timeout
	Floor2.visible = false
	await get_tree().create_timer(1).timeout
	Floor3.visible = false
	await get_tree().create_timer(1).timeout
	Floor4.visible = false
	await get_tree().create_timer(.9).timeout
	Floor5.visible = false
	await get_tree().create_timer(.7).timeout
	Floor6.visible = false
	await get_tree().create_timer(.5).timeout
	Mouse.visible = false
	await get_tree().create_timer(.3).timeout
	Keyboard.visible = false
	await get_tree().create_timer(.3).timeout
	Phone.visible = false
	await get_tree().create_timer(.3).timeout
	Desk.visible = false
	await get_tree().create_timer(.3).timeout
	Chair.visible = false
	await get_tree().create_timer(.3).timeout
	PC.visible = false
	await get_tree().create_timer(3).timeout
	transition.play("fade_in")
func send_message(text, side):
	screen.level_parent.get_child(0).send_message(text, side)

func set_options(one, two):
	Global.options = [one, two]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Global.isPhoneRinging:
		phone_ring()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("pause"):
		
		if not Global.isPaused:
			pause()
		else:
			unpause()

func pause():
	if not Global.isPaused:
		pause_instance = pause_scene.instantiate()
		add_child(pause_instance)
		Global.isPaused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause():
	if Global.isPaused:
		remove_child(pause_instance)
		Global.isPaused = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
func displayPhoneText(text):
	phone_chat_box.set_text(text)

func phone_ring():
	if not sound_ringing.playing:
		sound_ringing.play()
	Global.isPhoneRinging = true
	if Input.is_action_just_released("change_view") and Global.isLookingAtPhone:
		Global.isPhoneRinging = false
		sound_ringing.stop()
		Global.callAnswered = true
		displayPhoneText(current_text)
