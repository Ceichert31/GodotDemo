extends Area2D

@onready var timer: Timer = $Timer
@onready var hurt_sfx: AudioStreamPlayer2D = $HurtSFX

func _on_body_entered(body: Node2D) -> void:
	print("You Died!")
	
	#Slow time
	Engine.time_scale = 0.5
	
	#Find and remove players collider
	body.get_node("CollisionShape2D").queue_free()
	
	hurt_sfx.play()
	
	#Start reset timer
	timer.start()

#Reset Scene
func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
