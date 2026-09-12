extends Node2D
class_name EnemySpawner

@export_category("Enemy")
@export var enemy_scene: PackedScene

@export_category("Spawning")
@export var spawn_interval: float = 3.0
@export var min_spawn_distance: float = 350.0
@export var max_spawn_distance: float = 550.0
@export var max_enemies: int = 25

@export_category("Hordes")
@export var burst_chance: float = 0.25
@export var burst_min_count: int = 3
@export var burst_max_count: int = 6

var target_player: Node2D
var spawn_timer: float


func _ready() -> void:
	randomize()
	target_player = get_tree().get_first_node_in_group("player")
	spawn_timer = spawn_interval


func _process(delta: float) -> void:
	if enemy_scene == null or not is_instance_valid(target_player):
		return

	spawn_timer -= delta

	if spawn_timer <= 0.0:
		spawn_timer = spawn_interval
		spawn_wave()


func spawn_wave() -> void:
	var count := 1

	if randf() < burst_chance:
		count = randi_range(burst_min_count, burst_max_count)
		print("Enemy horde incoming! Spawning ", count, " enemies.")

	for i in count:
		if get_tree().get_nodes_in_group("enemy").size() >= max_enemies:
			break

		spawn_enemy()


func spawn_enemy() -> void:
	var enemy := enemy_scene.instantiate()
	var angle := randf() * TAU
	var distance := randf_range(min_spawn_distance, max_spawn_distance)
	var offset := Vector2(cos(angle), sin(angle)) * distance

	enemy.global_position = target_player.global_position + offset

	get_tree().current_scene.add_child(enemy)
