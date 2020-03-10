extends RigidBody2D

const MOVE_SPEED = 550

onready var player = get_node("../Player")
onready var area := $Area1
onready var area2 = $Area2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if area.overlaps_body(player):
		add_force(Vector2(MOVE_SPEED, 0), Vector2(0, -1))
	if area2.overlaps_body(player):
		add_force(Vector2(-1 * MOVE_SPEED, 0), Vector2(0, -1))
	pass