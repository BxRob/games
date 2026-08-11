extends Node2D

func _draw() -> void:
	draw_line(Vector2.ZERO, Vector2(0, -50), Color.WHITE, 4.0)
	draw_line(Vector2(0, -50), Vector2(-8, -38), Color.WHITE, 4.0)
	draw_line(Vector2(0, -50), Vector2(8, -38), Color.WHITE, 4.0)
