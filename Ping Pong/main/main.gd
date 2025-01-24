extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_ball_died.connect(on_ball_died)


func on_ball_died():
	GameManager.load_title_scene()
