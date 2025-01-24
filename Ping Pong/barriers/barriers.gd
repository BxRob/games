extends Node2D


func _on_area_2d_body_entered(_body):
	call_deferred("reload_scene")
	

func reload_scene():
	ScoreManager.reset_score()
	SignalManager.on_ball_died.emit()
