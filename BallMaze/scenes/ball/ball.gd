extends RigidBody2D


var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Reset the linear velocity to ensure the RigidBody2D only moves when the key is pressed
	linear_velocity = Vector2.ZERO

	if Input.is_action_pressed("right"):
		# Set the velocity to move the RigidBody2D to the right
		linear_velocity.x = speed


func _integrate_forces(state):
	pass
	# This function is called during the physics processing step
	#if Input.is_action_pressed("right"):
		### Apply a force to move the RigidBody2D to the right
		#print("pressed right")
		#apply_impulse(Vector2.ZERO, Vector2(speed, 0))
