extends CharacterBody3D


@onready var camera = Camera3D
@onready var crosshair = $Crosshair

var rot_x = 0
var rot_y = 0

signal change_view

var camPositionPc = Vector3(0.01, 3.3, -2.784)
var camPositionFree = Vector3(0.01, 3.5, -4)


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if not Global.isUsingPc:
			rot_x += -event.relative.x * Global.LOOK_SENSITIVITY
			rot_x = clamp(rot_x, -1.9, 1.9)
			rot_y += event.relative.y * Global.LOOK_SENSITIVITY
			rot_y = clamp(rot_y, -1.5, 1.5)
			transform.basis = Basis() # reset rotation
			rotate_object_local(Vector3(0, 1, 0), rot_x) # first rotate in Y
			rotate_object_local(Vector3(1, 0, 0), rot_y) # then rotate in X
			
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	elif Input.is_action_just_released("change_view"):
		if Global.isUsingPc: 
			stopUsingPC()
			
		elif not Global.isUsingPc and Global.isLookingAtPc: 
			usePC()
		print(Global.isLookingAtPc)
		


func tween_camera_position(newPosition, duration):
	get_tree().create_tween().tween_property(self,"position",newPosition, duration,)

func tween_camera_rotation(newRotation, duration):
	get_tree().create_tween().tween_property(self,"rotation",newRotation, duration,)

func usePC():
	Global.interacted_with_pc.emit()
	Global.isUsingPc = true
	crosshair.set_visible(false)
	
	rot_x = 0
	rot_y = 0
	
	tween_camera_position(camPositionPc, 0.3)
	tween_camera_rotation(Vector3(0, 0, 0), 0.3)
	
func stopUsingPC():

	Global.isUsingPc = false
	crosshair.set_visible(true)
	tween_camera_position(camPositionFree, 0.3)
