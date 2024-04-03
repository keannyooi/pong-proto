extends CanvasLayer

@onready var player_score_label = %PlayerScoreLabel
@onready var ai_score_label = %AIScoreLabel

func update_ai_score(ai_score):
	ai_score_label.text = str(ai_score)

func update_player_score(player_score):
	player_score_label.text = str(player_score)
