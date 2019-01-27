extends KinematicBody2D

const MOVE_SPEED = 100

var mob_types = ["walk", "swim", "fly"]
export (int) var detect_radius
export (float) var fire_rate
export (PackedScene) var Bullet
var vis_color = Color(.867, .91, .247, 0.1)
var laser_color = Color(1.0, .329, .298)

var target
var hit_pos
var can_shoot = true

func _ready():
	$AnimatedSprite.self_modulate = Color(0.2, 0, 0)
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	$Visibility/CollisionShape2D.shape = shape
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$ShootTimer.wait_time = fire_rate

func _physics_process(delta):
	update()
	if target:
		aim(delta)

func aim(delta):
	if target.name == "Player":
		$AnimatedSprite.self_modulate.r = 1.0
		rotation = (target.position - position).angle()
		var vec_to_player = target.global_position - global_position
		vec_to_player = vec_to_player.normalized()
		global_rotation = atan2(vec_to_player.y, vec_to_player.x)
		if vec_to_player.length() < 100:
			move_and_collide(vec_to_player * MOVE_SPEED * delta)
			if can_shoot:
				shoot(target.position)

func shoot(pos):
	var b = Bullet.instance()
	var a = (pos - global_position).angle()
	b.start(global_position, a + rand_range(-0.05, 0.05))
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)
	if target:
		draw_circle((target.position - position).rotated(-rotation), 5, laser_color)
		draw_line(Vector2(), (target.position - position).rotated(-rotation), laser_color)

func _on_Visibility_body_entered(body):
	print("lala")
	if target:
		return
	target = body


func _on_Visibility_body_exited(body):
	print("bar")
	if body == target:
		target = null
		$AnimatedSprite.self_modulate.r = 0.2


func _on_ShootTimer_timeout():
	can_shoot = true
 
 
func kill():
	queue_free()