extends CanvasLayer


@onready var health_bar: ProgressBar = $Bar/HBoxContainer/HealthBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ui: CanvasLayer = %UI

#region 虚方法
func _ready() -> void:
	animation_player.play("enter")
#endregion

#region 更新血量UI
func _on_player_ui_update(v : float) -> void:
	health_bar.value = v
#endregion

#region 根据是否暂停来确定是否隐藏血条
func _on_ui_visibility_changed() -> void:
	if ui.visible:
		animation_player.play("exit")
	else :
		animation_player.play("enter")
#endregion
