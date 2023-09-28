extends Area2D

var speed = 20
var dmg = 1
var velocity = Vector2.ZERO
var effects = null
var Explosion = load("res://Effects/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(0, -speed).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position += velocity


func _on_body_entered(body):
	if body.has_method("damage"):
		body.damage(dmg)
	effects = get_node_or_null("/root/Game/FX")
	if effects != null:
		var explosion = Explosion.instantiate()
		effects.add_child(explosion)
		explosion.global_position = global_position
	queue_free()


func _on_timer_timeout():
	queue_free()
