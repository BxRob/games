extends Node


const SCORES_PATH = "user://pingpong.json"

var score := 0
var high_score := 0


func _ready():
	load_from_disc()


func increment_score():
	set_score(score + 1)


func get_score():
	return score


func get_high_score():
	return high_score


func set_score(v: int):
	score = v
	if score > high_score:
		high_score = score
		save_to_disc()


func reset_score():
	score = 0


func save_to_disc():
	var file = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	var score_json_str = JSON.stringify(high_score)
	file.store_string(score_json_str)


func load_from_disc():
	var file = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if file == null:
		save_to_disc()
	else:
		var data = file.get_as_text()
		high_score = JSON.parse_string(data)
