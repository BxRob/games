extends Control

@onready var label: Label = $Label
var score := 0


func _ready() -> void:
	Scoremanager.score_changed.connect(_on_score_changed)


func _on_score_changed() -> void:
	label.text = str(Scoremanager.score)
