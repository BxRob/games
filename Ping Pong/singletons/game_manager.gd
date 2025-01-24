extends Node


var title_scene: PackedScene = preload("res://title/title.tscn")
var main_scene: PackedScene = preload("res://main/main.tscn")


func load_game_scene():
	get_tree().change_scene_to_packed(main_scene)


func load_title_scene():
	get_tree().change_scene_to_packed(title_scene)
