extends KinematicBody2D

signal recuerdos_changed

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		global.capturar_recuerdo()
		emit_signal("recuerdos_changed")
		queue_free()
	pass # replace with function body
