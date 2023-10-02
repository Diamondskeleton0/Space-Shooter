extends Node

var VP = Vector2.ZERO

var score = 0
var time = 30
var lives = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().size_changed.connect(_resize)

func _resize():
	VP = get_viewport().size

func _reset():
	get_tree().paused = false
	score = 0
	time = 30
	lives = 5

func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_score()

func update_lives(l):
	lives += l
	if lives == 0:
		get_tree().change_scene_to_file("res://UI/End_Game.tscn")
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_lives()

func _unhandled_input(event):
	if event.is_action_pressed("Menu"):
		var Menu = get_node_or_null("/root/Game/UI/Menu")
		if Menu == null:
			get_tree().quit()
		else:
			if Menu.visible:
				get_tree().paused = false
				Menu.hide()
			else:
				get_tree().paused = true
				Menu.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("Menu"):
		get_tree().quit()
		
func _physics_process(_delta):
	var Asteroid_Container = get_node_or_null("/root/Game/Asteroid_Container")
	var Enemy_Container = get_node_or_null("/root/Game/Enemy_Container")
	if Asteroid_Container != null and Enemy_Container != null:
		if Asteroid_Container.get_child_count() == 0 and Enemy_Container.get_child_count() == 0:
			get_tree().change_scene_to_file("res://UI/End_Game.tscn")
