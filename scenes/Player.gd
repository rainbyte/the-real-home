extends KinematicBody2D

signal hit

export (PackedScene) var Bullet

export var speed = 400 # How fast player will move (pixels/sec)
var screensize # Size of the game window
var velocity = Vector2()
var orientation = Vector2()

# Aparentement cuando un nodo es cargado, se ejecuta esta función
func _ready():
	screensize = get_viewport_rect().size
	hide()


func get_input():
	if Input.is_action_just_pressed("ui_select"):
		call_deferred("shoot", self.position)
	# Podemos cambiar las teclas en Project Settings/Input Map
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1


func _physics_process(delta):
	update()
	get_input()
	velocity = move_and_slide(velocity)

	if velocity.length() > 0:
		orientation = velocity.normalized()
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	# $CollisionShape2D.shape.height
	# $CollisionShape2D.shape.radius
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func shoot(pos):
	var bullet = Bullet.instance()
	var angle = orientation.angle() + rand_range(-0.05, 0.05)
	bullet.start(global_position + orientation * 50, angle)
	get_parent().add_child(bullet)


# Update en cada frame
func _process(delta):
	pass


func _on_DamageArea_body_entered(body):
	if body.name == "Mob":
		global.playerHP -=1
		print(global.playerHP)
		emit_signal("hit")
		if global.playerHP == 0 :
			$CollisionShape2D.call_deferred("set_disabled", true)
			game_over()


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func game_over():
	show_message("Game Over")
	global.goto_scene("res://scenes/Main.tscn")