extends Node3D

@onready var subviewport = $SubViewport
@onready var cursor: Sprite2D = $SubViewport/One/Cursor
@onready var buttons = {}
@export var export_level: PackedScene
@onready var current_level = export_level.instantiate()
@onready var level_parent = $SubViewport/One/Level

@onready var animation_player = $AnimationPlayer

@onready var one = $SubViewport/One
@onready var two = $SubViewport/Two
@onready var Black = $SubViewport/One/Black

signal buttonTab1
signal buttonTab2
signal buttonTab3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one.visible = false
	two.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.mousePosition = cursor.position
	
	
func _input(event):
	if event is InputEventMouseMotion:
		if Global.isUsingPc and not Global.isPaused:
			cursor.position.x += event.relative.x * Global.MOUSE_SENSITIVITY * 100
			cursor.position.y += event.relative.y * Global.MOUSE_SENSITIVITY * 100
			cursor.position = Vector2(clamp(cursor.position.x, 0, 512), clamp(cursor.position.y, 0, 384))

func clear_level():
	for i in range(0, level_parent.get_child_count()): level_parent.get_child(i). queue_free()


func change_level(instance):
	
		
	
		one.visible = false
		two.visible = true
		if level_parent.get_child_count() > 0:
			for i in range(0, level_parent.get_child_count()): level_parent.get_child(i). queue_free()
		level_parent.add_child(instance)

func logo_anim():
	animation_player.play("turn_on")

func _on_level_child_entered_tree(node: Node) -> void:
	await get_tree().process_frame
	one.visible = true
	two.visible = false
	
	logo_anim()
	Global.isPcOn = true
