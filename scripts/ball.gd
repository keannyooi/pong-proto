extends CharacterBody2D

signal player_hit_ball
signal player_wins
signal ai_wins

@export var start_speed: float = 500.0
@export var accel: float = 50.0
@export var max_y_vector: float = 0.6

@onready var respawn_timer = $RespawnTimer
@onready var player_paddle = $"../PlayerPaddle"
@onready var ai_paddle = $"../AIPaddle"

var current_speed: float = 0.0
var direction: Vector2
var viewport_size: Vector2

func _ready() -> void:
	viewport_size = get_viewport().size

func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = (
		move_and_collide(direction * current_speed * delta)
	)
	if collision:
		var collider: Object = collision.get_collider()
		if collider == player_paddle:
			player_hit_ball.emit()
			
		if collider == player_paddle or collider == ai_paddle:
			current_speed += accel
			direction = bounce_off_paddle(collider)
		else:
			direction = direction.bounce(collision.get_normal())

func _on_respawn_timer_timeout() -> void:
	spawn_ball()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if position.x < 0:
		player_wins.emit()
	else:
		ai_wins.emit()
	
	respawn_timer.start()

func bounce_off_paddle(paddle) -> Vector2:
	var distance_y: float = position.y - paddle.position.y
	
	var new_direction := Vector2.ZERO
	new_direction.x = direction.x - (direction.x * 2)
	new_direction.y = distance_y / (paddle.paddle_size / 2) * max_y_vector
	return new_direction.normalized()

func random_direction() -> Vector2:
	var new_direction := Vector2.ZERO
	new_direction.x = [1, -1].pick_random()
	new_direction.y = randf_range(-1, 1)

	return new_direction.normalized()

func spawn_ball() -> void:
	position.x = viewport_size.x / 2
	position.y = viewport_size.y / 2 + randi_range(-200, 200)
	current_speed = start_speed
	
	direction = random_direction()
