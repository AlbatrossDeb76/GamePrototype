extends CharacterBody3D

var _canTarget;
var _heath
# Called when the node enters the scene tree for the first time.
func _ready():
	_canTarget = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	velocity.y -= 9.8 * delta
	move_and_slide()
	
	


func on_screen():
	#_canTarget will be used for camera lock(not yet implemented)
	_canTarget = true
	#not drawing the mob if its not on the screen.
	visible = true

func on_screen_screen_exited():
	_canTarget = false
	visible = false
