extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer


#region 开始游戏的按钮
func _on_start_game_pressed() -> void:
	animation_player.play("start")
#endregion

#region 退出游戏的按钮
func _on_exit_game_pressed() -> void:
	animation_player.play("exit")
	get_tree().quit()
#endregion

#region 其它方法
func change_scene() -> void:
	get_tree().change_scene_to_file("res://Scenes/Worlds/world.tscn")
#endregion
