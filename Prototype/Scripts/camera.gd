extends Node3D

var camrot_h = 0
var camrot_v = 0
#camera speed
var speed = 3
var _event
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _unhandled_input(event):
		_event =event
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		var look = Input.get_vector("look_left", "look_right", "look_up", "look_down")
		$h.rotation_degrees.y += look.x * speed
		$h/v.rotation_degrees.x -= look.y * speed
		var camera_rotation = $h.rotation_degrees
		var direction = Vector3(look.x, 0, look.y).rotated(Vector3(0, 1, 0), camera_rotation.y).normalized()
		
		
	



func _on_player_lock_on():
	#thinking something like find the lockable closest to the center of the screen
	# when the signal is emited locks the camera towards that object
	pass
