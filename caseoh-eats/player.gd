extends CharacterBody2D

@export var base_speed = 200.0
var weight := 0.0
var current_speed := 0.0

func _physics_process(delta):
	var direction := 0.0
	if Input.is_action_pressed("ui_left"):
		direction -= 1.0
	if Input.is_action_pressed("ui_right"):
		direction += 1.0

	# Movement speed scales with weight
	current_speed = base_speed * (1.0 / (1.0 + weight * 0.1))
	velocity.x = direction * current_speed
	velocity.y = 0
	move_and_slide()

	clamp_to_screen()

func clamp_to_screen():
	var screen_size = get_viewport_rect().size
	var sprite_half_width = (get_node("Sprite2D").texture.get_width() * get_node("Sprite2D").scale.x) / 2.0
	position.x = clamp(position.x, sprite_half_width, screen_size.x - sprite_half_width)

func apply_food_effect(effect: Dictionary):
	weight += effect.get("weight_change", 0)
	print(weight)
	print(current_speed)
