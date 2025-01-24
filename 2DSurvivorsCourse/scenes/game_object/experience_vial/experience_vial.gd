extends Node2D


func _ready():
	$Area2D.area_entered.connect(on_area_enetered)


func on_area_enetered(other_area: Area2D):
	GameEvents.emit_experience_vial_collected(1)
	queue_free()
	
