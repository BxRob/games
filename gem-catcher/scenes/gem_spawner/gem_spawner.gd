extends Node2D

@export var gem_scene: PackedScene
@export var spawn_interval := 1.5  # seconds
@onready var timer := $Timer
var score

func _ready():
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_gem)
	timer.start()

func spawn_gem():
	if not gem_scene:
		return

	# create an instance of the PackedScene
	var gem = gem_scene.instantiate()

	var screen_width = get_viewport_rect().size.x
	var margin = 50  # pixels from each edge
	var spawn_x = randf_range(margin, screen_width - margin)
	gem.position = Vector2(spawn_x, -50)

	# Add to container (or to self if you prefer)
	add_child(gem)
