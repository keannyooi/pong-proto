extends StaticBody2D

@export var paddle_speed = 200.0

@onready var collision_shape_2d = $CollisionShape2D

var viewport_size: Vector2
var paddle_size: int

func _ready():
	viewport_size = get_viewport().size
	paddle_size = collision_shape_2d.shape.get_rect().size.y

func _process(delta):
	var input_axis: float = Input.get_axis("player_up", "player_down")
	handle_movement(input_axis, delta)

func handle_movement(input_axis, delta):
	if input_axis != 0.0:
		position.y += input_axis * paddle_speed * delta 
	
	position.y = clamp(position.y, paddle_size / 2,
		viewport_size.y - (paddle_size / 2))
