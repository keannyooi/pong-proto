extends StaticBody2D

@export var paddle_speed: float = 200.0

@onready var collision_shape_2d = $CollisionShape2D

var viewport_size: Vector2
var paddle_size: int

func _ready() -> void:
	viewport_size = get_viewport().size
	paddle_size = collision_shape_2d.shape.get_rect().size.y

func _process(delta: float) -> void:
	var input_axis: float = Input.get_axis("player_up", "player_down")
	handle_movement(input_axis, delta)

func handle_movement(input_axis: float, delta: float) -> void:
	if input_axis != 0.0:
		position.y += input_axis * paddle_speed * delta 
	
	position.y = clamp(position.y, paddle_size / 2,
		viewport_size.y - (paddle_size / 2))
