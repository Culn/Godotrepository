extends Sprite2D

var angular_speed = PI
var speed = 400.0

func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("turn_left"):
		direction = -1
	if Input.is_action_pressed("turn_right"):
		direction = 1
		
	rotation += direction * angular_speed * delta
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("forward"):
		velocity = Vector2.UP.rotated(rotation) * speed
		
	if Input.is_action_pressed("reverse"):
		velocity = Vector2.DOWN.rotated(rotation) * speed
	
	position += velocity * delta
