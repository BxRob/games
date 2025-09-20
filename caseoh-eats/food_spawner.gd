extends Node2D

@export var food_scenes: Array[PackedScene]
@export var spawn_interval := 1.5  # seconds
@onready var food_container := $"../FoodContainer"
@onready var timer := $Timer

func _ready():
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_food)
	timer.start()

func spawn_food():
	if food_scenes.is_empty():
		return

	var food_scene = food_scenes.pick_random()
	var food = food_scene.instantiate()
	
	var screen_width = get_viewport_rect().size.x
	var margin = 50  # pixels from each edge
	var spawn_x = randf_range(margin, screen_width - margin)
	food.position = Vector2(spawn_x, -50)
	
	food_container.add_child(food)
