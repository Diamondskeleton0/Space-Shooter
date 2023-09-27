extends CharacterBody2D

var speed = 0
var acc = 20
var decel = 5
const maxSpeed = 600
const minSpeed = 0
var rotSpeed = 0
var rotAcc = 0.02
const maxRotSpeed = 0.14
const minRotSpeed = 0
var nose = Vector2(0, -60)
var Bullet = load("res://Player/bullet.tscn")

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
		var Effects = get_node_or_null("/root/Game/FX")
		if Effects != null:
			Effects.add_child(bullet)

