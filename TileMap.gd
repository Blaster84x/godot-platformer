extends TileMap

signal player_death

var playerPos
var onLadder := false

export var deadly_tile_names := ["magma"]
export var air_jump_powerups := ["up_block"]

onready var player = $"../Player"
onready var playerX : int
onready var playerY : int
onready var tileset = self.get_tileset()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# get tile colliding with player
	playerPos = player.get_global_position()
	playerX = playerPos.x
	playerY = playerPos.y
	var cell = self.get_cell(playerX/64, playerY/64) 
	var tileName = tileset.tile_get_name(cell)
	# BEGIN TILE LOGIC BLOCK
	if tileName in air_jump_powerups:
		player.air_jump_unlocked = true
		set_cell(playerX/64, playerY/64, -1)
		
	if tileName in deadly_tile_names:
		emit_signal("player_death")
		
	pass
