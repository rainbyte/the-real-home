extends Node2D


func _ready():
	$Player.start($StartPosition.position)
	$CanvasLayer/recuerdos.text	 = "Recuerdos : " + str(global.recuerdos)
	$CanvasLayer/player_hp.text = "Player Hp : " + str(global.playerHP)


func _on_Player_hit():
	$CanvasLayer/player_hp.text = "Player Hp : " + str(global.playerHP)
