extends Node
# Booleans
var isUsingPc = false
var isPaused = false
var isPcOn = false
var isLookingAtPc = false
var isPhoneRinging = false
var canUsePc = false
var callAnswered = false
var isLookingAtPhone = false
var last_response = ''
signal text_finished
signal interacted_with_pc
signal send_message(text, side)
signal message_sent
signal wheel_select(bool)
signal work_completed()

var progress := 0.0
var progress_max := 10.0
var left_png = ''
var right_png = ''
var level = 1
var options = []

var mousePosition = Vector2(0, 0)
var LOOK_SENSITIVITY = 0.003
var MOUSE_SENSITIVITY = 0.003

var chat_history = []

var audio = 0
