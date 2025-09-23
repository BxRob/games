extends Node

var score := 0
signal score_changed

func increase_score() -> void:
	score += 1
	score_changed.emit()
