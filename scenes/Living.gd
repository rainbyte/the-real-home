extends Node2D

export (PackedScene) var Mob

func _ready():
	$Player.start($StartPosition.position)
	$CanvasLayer/recuerdos.text	 = "Recuerdos : " + str(global.recuerdos)
	$CanvasLayer/player_hp.text = "Player Hp : " + str(global.playerHP)
	$MobTimer.start()


func _on_Player_hit():
	$CanvasLayer/player_hp.text = "Player Hp : " + str(global.playerHP)



func show_message(text):
	$CanvasLayer/MessageLabel.text = text
	$CanvasLayer/MessageLabel.show()
	$CanvasLayer/MessageTimer.start()


func _on_Player_gameover():
	show_message("GAME OVER")
	$MobTimer.stop()


func _on_MobTimer_timeout():
    # Choose a random location on Path2D.
    $MobPath/MobSpawnLocation.set_offset(randi())
    # Create a Mob instance and add it to the scene.
    var mob = Mob.instance()
    add_child(mob)
    # Set the mob's direction perpendicular to the path direction.
    var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
    # Set the mob's position to a random location.
    mob.position = $MobPath/MobSpawnLocation.position
    # Add some randomness to the direction.
    direction += rand_range(-PI / 4, PI / 4)
    mob.rotation = direction
    # Choose the velocity.
    #mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))

func _on_recuerdos_changed():
	$CanvasLayer/recuerdos.text	 = "Recuerdos : " + str(global.recuerdos)
