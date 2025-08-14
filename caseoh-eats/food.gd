extends Area2D

@export var food_type := "bad"  # "good" or "bad"
@export var weight_change := 1.0
@export var fall_speed := 100.0
@export var eat_sound: AudioStream  # Unique per food scene

func _ready():
	match food_type:
		"good":
			weight_change = -1.0
		"bad":
			weight_change = +1.0

func _physics_process(delta):
	position.y += fall_speed * delta
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var actual_effect := {
			"weight_change": weight_change
		}

		# Optionally customize effect more based on type
		if food_type == "good":
			print("Ate healthy food!")
		elif food_type == "bad":
			print("Ate junk food!")

		if eat_sound:
			SoundManager.play_sound(eat_sound)
		
		body.apply_food_effect(actual_effect)
		queue_free()
