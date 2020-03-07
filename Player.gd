extends KinematicBody2D

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const DEATH_LOW_LIMIT = -1120

onready var anim_player = $AnimatedSprite
onready var sprite = anim_player

var y_velo := 0
var facing_right := false
var has_air_jump := false
export var air_jump_unlocked := true
onready var spawn_point := self.get_global_position()

func _ready():
	get_node("../TileMap").connect("player_death", self, "death")
	spawn_point = self.get_global_position()

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if Input.is_action_just_pressed("jump"):
		if grounded:
			y_velo = -JUMP_FORCE
		if has_air_jump and air_jump_unlocked:
			y_velo = -JUMP_FORCE
			has_air_jump = false
	if grounded and y_velo >= 0:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
	
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
	
	if grounded:
		has_air_jump = true
		if move_dir == 0:
			play_anim("idle")
		else:
			play_anim("walk")
	else:
		play_anim("jump")
		
func death():
	self.set_global_position(spawn_point)
	get_node("AudioStreamPlayer2D").play()

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.animation == anim_name:
		return
	anim_player.play(anim_name)