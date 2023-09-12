extends CharacterBody2D

var speed = 0
var acc = 10
var decel = 5
const maxSpeed = 600
const minSpeed = 0
var rotSpeed = 0
var rotAcc = 0.02
const maxRotSpeed = 0.14

func _physics_process(_delta):
	if Input.is_action_pressed("Rotate Left"):
		rotSpeed -= rotAcc
		if(rotSpeed < (maxRotSpeed * -1)):
			rotSpeed = (maxRotSpeed * -1)
		rotation += rotSpeed
	if Input.is_action_pressed("Rotate Right"):
		rotSpeed += rotAcc
		if(rotSpeed > maxRotSpeed):
			rotSpeed = maxRotSpeed
		rotation += rotSpeed
	if Input.is_action_pressed("Move Forward"):
		speed += acc
		if(speed > maxSpeed):
			speed = maxSpeed
		velocity += Vector2(0, -speed).rotated(rotation)
	elif !Input.is_action_just_released("Move Forward"):
		speed -= decel
		if(speed < minSpeed):
			speed = minSpeed
	if Input.is_action_just_released("Rotate Left"):
		rotSpeed = 0
	if Input.is_action_just_released("Rotate Right"):
		rotSpeed = 0
	
	position.x = wrap(position.x, -50, 1200)
	position.y = wrap(position.y, -50, 700)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, speed)
	
	move_and_slide()

