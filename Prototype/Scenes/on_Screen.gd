extends VisibleOnScreenNotifier3D
signal _visable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_on_screen()):
		emit_signal("_visable")
