extends CanvasGroup
signal startgame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_button():
	$Button.show()
	
func update_message(msg):
	$Message.show()
	$Message.text = msg
	
	
func update_lives(lives):
	$LivesCounter.text = str(lives)


func _on_button_pressed():
	$Message.hide()
	startgame.emit()
	$Button.hide()
