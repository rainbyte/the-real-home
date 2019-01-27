extends Node2D


func _ready():
	$Player.start($StartPosition.position)
	$CanvasLayer/recuerdos.text	 = "Recuerdos : " + str(global.recuerdos)
	$CanvasLayer/player_hp.text = "Player Hp : " + str(global.playerHP)


func _on_Player_hit():
	$CanvasLayer/player_hp.text = "Player Hp : " + str(global.playerHP)



func show_message(text):
	$CanvasLayer/MessageLabel.text = text
	$CanvasLayer/MessageLabel.show()
	$CanvasLayer/MessageTimer.start()


func _on_Player_gameover():
	show_message("GAME OVER")
