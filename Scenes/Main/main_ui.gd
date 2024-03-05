extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_start_game_pressed() -> void:
	animation_player.play("start")


func _on_exit_game_pressed() -> void:
	animation_player.play("exit")
	get_tree().quit()

func change_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/Worlds/world.tscn")
