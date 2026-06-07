extends Area2D

@onready var CheckpointSFX: AudioStreamPlayer = $Ding
var checkpoint_reached: bool = false


func _on_body_entered(body: Node2D) -> void:
    if body.name == "Player":
        PlayerVariables.checkpoint = position
        CheckpointSFX.play()
        checkpoint_reached = true
    if checkpoint_reached == true:
      pass
