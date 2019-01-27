extends Node

var current_scene = null
var playerHP = 50
var recuerdos  = 0

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	get_tree().change_scene(path)
