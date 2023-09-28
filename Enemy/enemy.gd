extends CharacterBody2D

var y_positions = [100,150,200,500,550]
var initial_position = Vector2.ZERO
var direction = Vector2(1.5,0)
var wobble = 30.0

var health = 5

var Effects = null
var Bullet = load("res://Enemy/Bullet.tscn")
var Explosion = load("res://Effects/Explosion.tscn")

func _on_timer_timeout():
	var Player = get_node_or_null("/root/Game/PlayerContainer/Player")
	Effects = get_node_or_null("/root/Game/FX")
	if Player != null and Effects != null:
		var bullet = Bullet.instantiate()
		var d = global_position.angle_to_point(Player.global_position) + PI/2
		bullet.rotation = d
		bullet.position = global_position + Vector2(0, -80).rotated(d)
		Effects.add_child(bullet)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.damage(100)
		damage(100)

func damage(d):
	health -= d
	if health <= 0:
		queue_free()

func _ready():
	initial_position.x = -100
	initial_position.y = y_positions[randi() % y_positions.size()]
	position = initial_position

func _physics_process(_delta):
	position += direction
	position.y = initial_position.y + sin(position.x/20)*wobble
	if position.x > 1200:
		queue_free()
