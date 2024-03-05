class_name HealthSystem extends Node


@export var max_health := 100.0


@onready var current_health := max_health:
	get:
		return current_health
	set(v):
		current_health = v
		if current_health <= 0:
			current_health = 0
		elif current_health >= max_health:
			current_health = max_health


#region 恢复血量
func heal(v : float) -> void:
	current_health += v
#endregion

#region 受伤
func hurt(v : float) -> void:
	current_health -= v
#endregion
