extends Node

func play_sound(stream: AudioStream):
	if stream:
		var player = AudioStreamPlayer.new()
		add_child(player)
		player.stream = stream
		player.play()
		player.connect("finished", player.queue_free)
