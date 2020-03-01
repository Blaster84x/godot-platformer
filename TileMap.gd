extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var playerX : int
onready var playerY : int
onready var tileset = self.get_tileset()
export var deadly_tile_names := ["magma"]
var playerPos

signal player_death

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerPos = get_node("../Player").get_global_position()
	playerX = playerPos.x
	playerY = playerPos.y
	var cell = self.get_cell(playerX/64, playerY/64) 
	var tileName = tileset.tile_get_name(cell)
	if tileName in deadly_tile_names:
		emit_signal("player_death")
	pass
