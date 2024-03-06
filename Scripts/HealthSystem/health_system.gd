class_name HealthSystem extends Node

signal health_is_change
@export var max_health := 100.0

func _ready() -> void:
	health_is_change.emit(current_health / max_health * 100)

@onready var current_health := max_health:
	get:
		return current_health
	set(v):
		current_health = v
		if current_health <= 0:
			current_health = 0
		elif current_health >= max_health:
			current_health = max_health


var is_slow_heal := false
var slow_heal_time := 0.0

#region 恢复血量
func heal(v : float) -> void:
	current_health += v
	health_is_change.emit(current_health / max_health * 100)
#endregion

#region 受伤
func hurt(v : float) -> void:
	current_health -= v
	health_is_change.emit(current_health / max_health * 100)
#endregion

#region 缓慢回血
#func slow_heal(v : float, time : float) -> void:
	#slow_heal_time = 0.0
	#is_slow_heal = true
	#if time <= 0:
		#is_slow_heal = false
	#while time > 0:
		#if slow_heal_time >= .5:
			#heal(v)
			#time -= .5


#func _physics_process(delta: float) -> void:
	#if is_slow_heal:
		#slow_heal_time += delta
