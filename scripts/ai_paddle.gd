extends StaticBody2D

@export var paddle_speed: float = 200.0

@onready var collision_shape_2d = $CollisionShape2D

var ball_pos: Vector2
var ball_relative_direction_y: int
var distance_y: int

var viewport_size: Vector2
var paddle_size: int

func _ready() -> void:
	viewport_size = get_viewport().size
	paddle_size = collision_shape_2d.shape.get_rect().size.y

func _process(delta: float) -> void:
	calc_ball_relative_direction_y(delta)
	move_paddle(delta)

func calc_ball_relative_direction_y(delta: float) -> void:
	ball_pos = $"../Ball".position
	
	distance_y = ball_pos.y - position.y
	if abs(distance_y) > paddle_speed * delta: # avoiding division by zero error
		ball_relative_direction_y = distance_y / abs(distance_y)
	

func move_paddle(delta: float) -> void:
	if abs(distance_y) > paddle_speed * delta:
		position.y += paddle_speed * ball_relative_direction_y * delta
	else:
		position.y += distance_y
	
	position.y = clamp(position.y, paddle_size / 2,
		viewport_size.y - (paddle_size / 2))
