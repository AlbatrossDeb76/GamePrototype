extends CharacterBody3D

var _canTarget;
var _heath = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	_canTarget = false
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if _heath <= 0:
		get_parent().remove_child(self)
	velocity.y -= 9.8 * delta
	move_and_slide()
	


func on_screen__visible():
	#print("on")
	pass


func screen_not_visible():
	#print("off")
	pass


func _on_world_box_test_damage():
	_heath -= 1
	print(_heath)
