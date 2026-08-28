extends Node2D

@export_category("Attack")
@export var attack_damage: float = 25.0
@export var attack_cooldown: float = 0.35
@export var attack_range: float = 45.0

var cooldown_timer: float = 0.0
var attack_visual_timer: float = 0.0


func _ready() -> void:
	$AttackArea.position = Vector2(attack_range, 0.0)
	$AttackArea.monitoring = false


func _process(delta: float) -> void:
	cooldown_timer = max(cooldown_timer - delta, 0.0)
	attack_visual_timer = max(attack_visual_timer - delta, 0.0)

	aim_at_mouse()

	if Input.is_action_pressed("attack") and cooldown_timer <= 0.0:
		attack()

	queue_redraw()


func aim_at_mouse() -> void:
	var direction := get_global_mouse_position() - global_position

	if direction.length() > 0.0:
		rotation = direction.angle()


func attack() -> void:
	cooldown_timer = attack_cooldown
	attack_visual_timer = 0.08

	$AttackArea.monitoring = true

	await get_tree().create_timer(0.08).timeout

	$AttackArea.monitoring = false


func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var direction := Vector2.RIGHT.rotated(rotation)

		body.take_damage(
			attack_damage,
			direction
		)


func _draw() -> void:
	if attack_visual_timer > 0.0:
		draw_rect(
			Rect2(0, -15, 90, 30),
			Color.WHITE
		)
