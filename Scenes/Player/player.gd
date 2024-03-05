extends CharacterBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var head: RayCast2D = $CollisionPolygon2D/Head
@onready var feet: RayCast2D = $CollisionPolygon2D/Feet


@export var speed := 250.0
@export var jump_speed := -400.0
@export var wall_jump_speed := Vector2(500, -350.0)


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var dir := 0.0
var acceleration : float
var is_wall_jump := false
var air_time := 0.0

#region 虚方法
func _ready() -> void:
	air_time = 0
	acceleration = speed / .5
	animation_player.play("idle")


func _process(delta: float) -> void:
	if is_wall_slide() and not is_wall_jump:
		dir = -1 if sprite_2d.flip_h else 1
	else :
		dir = Input.get_axis("action_left", "action_right")
	is_flip()
	anim_player()


func _physics_process(delta: float) -> void:
	# 重力的变化
	if is_wall_jump:
		acceleration = speed / .2
	elif not is_on_floor() and not is_wall_slide():
		acceleration = speed / .2
		velocity.y += gravity * delta
	elif is_wall_slide():
		velocity.y = 0
		velocity.y += gravity * delta * .8
	
	# 跳越的情况设置
	if Input.is_action_just_pressed("action_jump"):
		if is_on_floor():
			air_time = 0
			velocity.y = jump_speed
		elif is_wall_slide():
			is_wall_jump = true
			velocity = wall_jump_speed
			velocity.x *= get_wall_normal().x
	
	# 再空中的时间
	if air_time > 0.1:
		air_time = 0
		is_wall_jump = false
		
	
	# 角色的移动
	velocity.x = move_toward(velocity.x, dir * speed, acceleration * delta)
	
	# 启用 velocity 移动
	move_and_slide()
	
	# 如果使用蹬墙跳再空中的不受重力时间
	if is_wall_jump:
		air_time += delta
#endregion

#region 角色翻转的代码
func is_flip() -> void:
	# 判断方向不为0时，根据 dir 的值修改 sprite 的 flip_h 的值
	if not is_zero_approx(dir):
		sprite_2d.flip_h = dir < 0
	
	# 修改碰撞体的方向，根据 sprite 的方向是否翻转来判断是否翻转 collision
	collision_polygon_2d.scale.x = -1 if sprite_2d.flip_h else 1
#endregion

#region 动画的切换
func anim_player() -> void:
	if is_on_floor():
		if is_zero_approx(dir) and is_zero_approx(velocity.x):
			animation_player.play("idle")
		else :
			animation_player.play("run")
	else :
		if is_wall_slide():
			animation_player.play("wall_slide")
		else :
			animation_player.play("jump")
#endregion

func is_wall_slide() -> bool:
	return head.is_colliding() and feet.is_colliding() and is_on_wall() and not is_on_floor()
