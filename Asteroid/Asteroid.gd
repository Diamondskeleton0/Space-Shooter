extends CharacterBody2D

var health = 10
var iSpeed = 300

func _ready():
	velocity = Vector2(0, randf() * iSpeed).rotated(randf() * 2 * PI)

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(100)
		queue_free()

func _physics_process(_delta):
	
	move_and_slide()

	position.x = wrap(position.x, -50, 1200)
	position.y = wrap(position.y, -50, 700)
