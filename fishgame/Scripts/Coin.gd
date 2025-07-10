extends Area2D

@onready var game_manager: Node = %GameManager

func _on_body_entered(body: Node2D) -> void:
	print("+1 Coin!")
	game_manager.add_to_score()
	queue_free()
