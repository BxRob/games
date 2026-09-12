extends CharacterBody2D
class_name TestEnemy

const PickupScene: PackedScene = preload("res://scenes/pickup.tscn")

@export_category("Enemy")
@export var max_health: float = 100.0
@export var move_speed: float = 120.0

@export_category("Knockback")
@export var knockback_strength: float = 250.0
@export var knockback_friction: float = 1000.0

@export_category("Drops")
@export var drop_chance: float = 1.0

var health: float
var hit_flash_timer: float = 0.0
var knockback_velocity: Vector2 = Vector2.ZERO
var target_player: Node2D


func _ready() -> void:
	health = max_health
	add_to_group("enemy")
	target_player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	hit_flash_timer = max(hit_flash_timer - delta, 0.0)

	knockback_velocity = knockback_velocity.move_toward(
		Vector2.ZERO,
		knockback_friction * delta
	)

	var chase_velocity := Vector2.ZERO

	if is_instance_valid(target_player):
		var direction := (target_player.global_position - global_position)

		if direction.length() > 1.0:
			chase_velocity = direction.normalized() * move_speed

	velocity = chase_velocity + knockback_velocity

	move_and_slide()

	queue_redraw()


func take_damage(amount: float, knockback_direction: Vector2 = Vector2.ZERO) -> void:
	health -= amount

	hit_flash_timer = 0.08

	if knockback_direction != Vector2.ZERO:
		knockback_velocity = knockback_direction.normalized() * knockback_strength

	print("Enemy health: ", health)

	if health <= 0.0:
		die()


func die() -> void:
	drop_pickup()
	queue_free()


func drop_pickup() -> void:
	if PickupScene == null:
		return

	if randf() > drop_chance:
		return

	var pickup := PickupScene.instantiate()
	pickup.global_position = global_position

	get_parent().add_child.call_deferred(pickup)


func _draw() -> void:
	var enemy_color := Color.RED

	if hit_flash_timer > 0.0:
		enemy_color = Color.WHITE

	draw_circle(Vector2.ZERO, 18.0, enemy_color)
