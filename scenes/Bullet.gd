extends Area2D

var speed = 500
var velocity = Vector2()

func start(pos, dir):
	position = pos + Vector2(80, 0).rotated(dir)
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	if body.name == "Mob":
		body.kill()

	if body.name == "Player":
		body.damage()
	
	queue_free()
	
	
	