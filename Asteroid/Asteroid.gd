extends CharacterBody2D

var iSpeed = 300

func _ready():
	velocity = Vector2(0, randf() * iSpeed).rotated(randf() * 2 * PI)

func _physics_process(_delta):
	
	move_and_slide()

	position.x = wrap(position.x, -50, 1200)
	position.y = wrap(position.y, -50, 700)
