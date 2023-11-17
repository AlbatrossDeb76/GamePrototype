extends CharacterBody3D


const SPEED = 11.50
const JUMP_VELOCITY = 17.0
const DASH_VELOCITY = 2.5
const dashTime = .20
var dashing = false
var hasTouchedGround
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var input_dir
signal _lock_on
signal _hit(test_mob, damage)
	

@onready var camera = $camroot/h/v/Camera3D.get_viewport().get_camera_3d()
@onready var test_mob = preload("res://Scenes/test_mob.tscn")
#gets input and sets the cam
func get_camera_relative_input(input) -> Vector3:
	#Relative x values
	var cam_right = -camera.global_transform.basis.x
	#Reletive Y values
	var cam_forward = camera.global_transform.basis.z
	# make cam_forward horizontal:
	cam_forward = cam_forward.slide(Vector3.UP).normalized()
	# return camera relative input vector:
	return cam_forward * input.y + cam_right * input.x


func _input(event):
	
	if Input.is_action_just_released("ui_pause"):
		_on_control_gui_input(Input)
	
	elif Input.is_action_just_pressed("ui_accept") and is_on_floor() and !dashing:	
		velocity.y =+ JUMP_VELOCITY
		hasTouchedGround = false
		
	
	
	if Input.is_action_just_pressed("Dash") and $Dash_Time.time_left == 0 and hasTouchedGround:
		hasTouchedGround = false
		$Dash_Time.start(dashTime)
		dashing =true
		if $Dash_Time.time_left > 0:
			print(velocity)
			velocity.z = velocity.z * DASH_VELOCITY
			velocity.x = velocity.x * DASH_VELOCITY
	#WIP
	if Input.is_action_just_pressed("attack"):
		_Attack()
	#nothing yet
	if Input.is_action_just_pressed("lock_on"):
		emit_signal("_lock_on")
		
func _physics_process(delta):
	
	#GD input map for movement
	input_dir = Input.get_vector("ui_right", "ui_left", "ui_up", "ui_down")

	
	#prevents the player from moving while the dash is in motion
	if  $Dash_Time.time_left == 0:
		dashing = false
		#moves in the given direction, reletive to camera input. offset the pos of the vector to avoid an error i dont know how to fix	
		$Lowpoly.look_at($Lowpoly/testmesh/Marker3D.global_transform.origin + Vector3(-get_camera_relative_input(input_dir).x, 0, -get_camera_relative_input(input_dir).z) + Vector3(.0001 ,0 ,0), Vector3.UP)
		#basic movent
		velocity.x = get_camera_relative_input(input_dir).x * SPEED
		velocity.z = get_camera_relative_input(input_dir).z * SPEED
		
	
	#cooldown timer for the attack button
	if $Att_Time.time_left == 0:
		$Lowpoly/testmesh.visible = false
		$Lowpoly/testmesh/ShapeCast3D.enabled = false
	
	if(is_on_floor()):
		hasTouchedGround = true

	if not is_on_floor():
		#added a little extra sauce for the player gravity
			velocity.y -= gravity * get_process_delta_time()*3.1
	
	move_and_slide()

func _Attack():
	$Att_Time.start(.15)
	if $Att_Time.time_left > 0:
		#turns on the colision shape for the attack
		$Lowpoly/testmesh/ShapeCast3D.enabled = true
		#debug shows a non colideable mesh for visual referance 
		$Lowpoly/testmesh.visible = true
		#debug for checking if colision is registering
			
		#print($Lowpoly/testmesh/ShapeCast3D.get_collider_rid(0))
		if $Lowpoly/testmesh/ShapeCast3D.is_colliding():
			_hit.emit(test_mob,1)



func _on_control_gui_input(event):
	#_on_control_focus_entered()
	pass

