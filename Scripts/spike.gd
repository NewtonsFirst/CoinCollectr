extends Node2D

@onready var HitSFX: AudioStreamPlayer = $HitSFX



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		HitSFX.play()
		PlayerVariables.Player_Health -= 10


