extends Label

@onready var player = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.isUsingPc:
		self.text = "E: Look Around"
	else:
		self.text = "E: Use Computer"
