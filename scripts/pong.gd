extends Node2D

@onready var ball = $Ball
@onready var ui = $UI

var player_score: int = 0
var ai_score: int = 0

func _ready() -> void:
	ui.update_ai_score(ai_score)
	ui.update_player_score(player_score)
	ball.respawn_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_ball_ai_wins() -> void:
	ai_score += 1
	ui.update_ai_score(ai_score)

func _on_ball_player_wins() -> void:
	player_score += 1
	ui.update_player_score(player_score)
