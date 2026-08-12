class_name Player
extends CharacterBody2D

const GRAVITY: float = 690
const RUN_SPEED: float = 100
const JUMP_CHARGE_SPEED := 1000.0
const MAX_JUMP_POWER := 400.0
const WALL_BOUNCE_SPEED := 100.0

var jump_charge := 0.0
var _was_on_floor: bool = false
var _start_position: Vector2

@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var land_sound: AudioStreamPlayer2D = $LandSound
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	_start_position = position


func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	handle_movement()
	flip_sprite()
	move_and_slide()
	handle_wall_bounce()
	check_landed()


func _process(_delta: float) -> void:
	var direction = get_global_mouse_position() - global_position

	if direction.length() > 0:
		$AimArrow.rotation = direction.angle() + PI / 2


func handle_movement() -> void:
	if is_on_floor():
		velocity.x = Input.get_axis("left", "right") * RUN_SPEED

		if Input.is_action_pressed("jump"):
			jump_charge += JUMP_CHARGE_SPEED * get_physics_process_delta_time()
			jump_charge = min(jump_charge, MAX_JUMP_POWER)

		if Input.is_action_just_released("jump"):
			var jump_direction = -$AimArrow.global_transform.y.normalized()

			velocity = jump_direction * jump_charge

			jump_charge = 0.0
			jump_sound.play()


func flip_sprite() -> void:
	if not is_zero_approx(velocity.x):
		sprite_2d.flip_h = velocity.x < 0


func check_landed() -> void:
	if not _was_on_floor and is_on_floor():
		land_sound.play()

	_was_on_floor = is_on_floor()


func fell_off() -> void:
	position = _start_position
	set_position.call_deferred(_start_position)


func handle_wall_bounce() -> void:
	if is_on_wall() and not is_on_floor():
		var wall_normal = get_wall_normal()

		velocity.x = wall_normal.x * WALL_BOUNCE_SPEED
