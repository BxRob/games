extends Area2D

@export var fall_speed := 200.0  # pixels per second

func _process(delta):
	position.y += fall_speed * delta

	# optional: remove gem when it leaves the bottom of the screen
	if position.y > get_viewport_rect().size.y:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		queue_free()  # Remove this Area2D
	Scoremanager.increase_score()
