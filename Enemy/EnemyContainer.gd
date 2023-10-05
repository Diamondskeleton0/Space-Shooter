extends Node2D

var Enemy = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Enemy = load("res://Enemy/enemy.tscn")
	make_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_child_count() == 0:
		make_enemy()

func make_enemy():
	var enemy = Enemy.instantiate()
	add_child(enemy)
