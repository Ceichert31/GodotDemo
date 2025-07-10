extends Area2D

@onready var game_manager: Node = %GameManager
@onready var pickup_sfx: AudioStreamPlayer2D = $PickupSFX
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	print("+1 Coin!")
	game_manager.add_to_score()
	animation_player.play("Pickup")
