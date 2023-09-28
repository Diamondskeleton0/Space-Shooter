extends CharacterBody2D

var health = 5
var speed = 0
var acc = 20
var decel = 5
const maxSpeed = 600
const minSpeed = 0
var rotSpeed = 0
var rotAcc = 0.02
const maxRotSpeed = 0.14
const minRotSpeed = 0
var nose = Vector2(0, -70)
var Bullet = load("res://Player/bullet.tscn")
var Explosion = load("res://Effects/Explosion.tscn")
var Effects = null

func get_input():
	if Input.is_action_pressed("Rotate Left"):
		rotSpeed -= rotAcc
		if(rotSpeed < (maxRotSpeed * -1)):
			rotSpeed = (maxRotSpeed * -1)
	if Input.is_action_pressed("Rotate Right"):
		rotSpeed += rotAcc
		if(rotSpeed > maxRotSpeed):
			rotSpeed = maxRotSpeed
	if Input.is_action_pressed("Move Forward"):
		speed += acc
		if(speed > maxSpeed):
			speed = maxSpeed
		velocity += Vector2(0, -acc).rotated(rotation)
	elif !Input.is_action_pressed("Move Forward"):
		speed -= decel
		if(speed < minSpeed):
			speed = minSpeed
	if !Input.is_action_pressed("Rotate Left") && rotSpeed < 0:
		rotSpeed += rotAcc
		if (rotSpeed >= minRotSpeed):
			rotSpeed = 0
	if !Input.is_action_pressed("Rotate Right") && rotSpeed > 0:
		rotSpeed -= rotAcc
		if (rotSpeed <= minRotSpeed):
			rotSpeed = 0

func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/FX")
		if Effects != null:
			var explosion = Explosion.instantiate()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			await explosion.animation_finished
		queue_free()

func _physics_process(_delta):
	get_input()
	
	rotation += rotSpeed
	position.x = wrap(position.x, -50, 1200)
	position.y = wrap(position.y, -50, 700)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		var bullet = Bullet.instantiate()
		bullet.rotation = rotation
		bullet.position = position + nose.rotated(rotation)
		var effects = get_node_or_null("/root/Game/FX")
		if effects != null:
			effects.add_child(bullet)

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		damage(100)
