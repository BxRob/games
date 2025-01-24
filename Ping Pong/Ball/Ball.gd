extends CharacterBody2D


const SPEED := 10
const JUMP_VELOCITY := -900.0

@onready var score := $Score
@onready var ball_sound := $BallSound

var gravity_increase := 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	#if started == false:
		#velocity.y = 0
	#else:
	velocity.y += gravity * gravity_increase * delta
	
	move_and_slide()
	

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			gravity_increase += 0.005
			print(gravity_increase)
			velocity.y = JUMP_VELOCITY
			if position.x == event.position.x:
				velocity.x = randf_range(-1, 1)
			else:
				velocity.x = (position.x - event.position.x) * SPEED
				
			ScoreManager.increment_score()
			score.text = str(ScoreManager.get_score())
			ball_sound.play()
