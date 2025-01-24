extends Node2D


@onready var score_sound = $ScoreSound

var _plane_died: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_plane_died.connect(on_plane_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta * GameManager.SCROLL_SPEED
	if position.x < -100:
		queue_free()


func on_plane_died():
	_plane_died = true
	set_process(false)


func _on_screen_exited():
	print("on_screen_exited")
	#queue_free()


func _on_laser_body_exited(body):
	if _plane_died == false and body.is_in_group(GameManager.GROUP_PLAYER):
		ScoreManager.increment_score()
		score_sound.play()


func _on_pipe_body_entered(body):
	if body.is_in_group("player"):
		body.die()
