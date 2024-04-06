extends Area2D
signal catch


@export var walk_speed = 200
@export var lives =3
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("walk_left"):
		velocity.x -= 1
	if Input.is_action_pressed("walk_right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * walk_speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		#flips sprite if travelling left
		$AnimatedSprite2D.flip_h = velocity.x < 0


func _on_body_entered(body):
	catch.emit()
	body.queue_free()
