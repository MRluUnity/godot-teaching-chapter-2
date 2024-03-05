extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer


#region 虚方法
func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("action_stop"):
		if visible:
			animation_player.play("exit")
		else :
			animation_player.play("enter")
	get_tree().paused = visible
#endregion

#region 继续游戏的按钮
func _on_continue_game_pressed() -> void:
	animation_player.play("exit")
#endregion

#region 返回主菜单的按钮
func _on_back_menu_pressed() -> void:
	animation_player.play("back")
#endregion

#region 其它方法
func change_sence() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")
#endregion
