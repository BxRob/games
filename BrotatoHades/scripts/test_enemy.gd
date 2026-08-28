extends CharacterBody2D
class_name TestEnemy

@export_category("Enemy")
@export var max_health: float = 100.0

@export_category("Knockback")
@export var knockback_strength: float = 250.0
@export var knockback_friction: float = 1000.0

var health: float
var hit_flash_timer: float = 0.0


func _ready() -> void:
	health = max_health


func _physics_process(delta: float) -> void:
	hit_flash_timer = max(hit_flash_timer - delta, 0.0)

	velocity = velocity.move_toward(
		Vector2.ZERO,
		knockback_friction * delta
	)

	move_and_slide()

	queue_redraw()


func take_damage(amount: float, knockback_direction: Vector2 = Vector2.ZERO) -> void:
	health -= amount

	hit_flash_timer = 0.08

	if knockback_direction != Vector2.ZERO:
		velocity = knockback_direction.normalized() * knockback_strength

	print("Enemy health: ", health)

	if health <= 0.0:
		die()


func die() -> void:
	queue_free()


func _draw() -> void:
	var enemy_color := Color.RED

	if hit_flash_timer > 0.0:
		enemy_color = Color.WHITE

	draw_circle(Vector2.ZERO, 18.0, enemy_color)
