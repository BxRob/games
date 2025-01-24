extends Node


var _score: int = 0
var _high_score: int = 0


func get_score():
	return _score


func get_high_score():
	return _high_score


func set_score(v: int):
	_score = v
	print("set_score: ", _score)
	if _score > _high_score:
		_high_score = _score
		print("set_score: ", _high_score)
	SignalManager.on_score_updated.emit()


func increment_score():
	set_score(_score + 1)


func set_high_score():
	pass
