extends Area2D
class_name Pickup

@export_category("Pickup")
@export var power_amount: float = 1.0

@export_category("Attraction")
@export var attract_radius: float = 140.0
@export var attract_speed: float = 420.0

var target_player: Node2D


func _ready() -> void:
	target_player = get_tree().get_first_node_in_group("player")
	body_entered.connect(_on_body_entered)


func _physics_process(delta: float) -> void:
	if not is_instance_valid(target_player):
		return

	var direction := target_player.global_position - global_position
	var distance := direction.length()

	if distance <= attract_radius and distance > 1.0:
		global_position += direction.normalized() * attract_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_power"):
		body.add_power(power_amount)
		queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 6.0, Color.CYAN)
