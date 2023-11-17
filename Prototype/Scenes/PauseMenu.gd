extends Control


# Called when the node enters the scene tree for the first time.
var button
func _ready():
	button = $VBoxContainer/Reset
	

func _gui_input(event):
	if Input.is_action_just_released("ui_pause") and get_tree().paused == false:
		#Makes the buttons selectable
		$VBoxContainer/Resume.grab_focus()
		#pauses the scene
		get_tree().paused = true
		#makes the box visable
		visible = true
		#TESTING
		print("start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_gui_input(Input)

func _on_reset_button_up():
	get_tree().reload_current_scene()
	print(get_tree().reload_current_scene())
	get_tree().paused = false
	

func _on_quit_button_up():
	get_tree().quit()


func _on_resume_button_down():
	visible = false
	get_tree().paused = false
	print("stop")
