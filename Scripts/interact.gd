extends RayCast3D

@onready var prompt = $Prompt
signal interacted_with_pc()

func _physics_process(delta: float) -> void:
	
	prompt.text = ""
	
	if is_colliding() and not Global.isUsingPc:
		var collider = get_collider()
		
		if collider is Interactable and not Global.isUsingPc and collider.name == 'ComputerHitbox' and Global.canUsePc:
			prompt.text = collider.prompt_message
			Global.isLookingAtPc = true
		else:
			Global.isLookingAtPc = false
	else:
		Global.isLookingAtPc = false
	
	if is_colliding():
		var collider = get_collider()
		if Global.isPhoneRinging and collider.name == 'PhoneHitbox':
			Global.isLookingAtPhone = true
			prompt.text = collider.prompt_message
	else:
		Global.isLookingAtPhone = false
