class_name GameGlobal extends Node2D


var old_scene


func enter_scene(scene, new_scene_name : String) -> void:
	get_tree().change_scene_to_file(new_scene_name)
	old_scene = scene

func exit_scene(scene) -> void:
	get_tree().change_scene_to_packed(old_scene)
	old_scene = scene
