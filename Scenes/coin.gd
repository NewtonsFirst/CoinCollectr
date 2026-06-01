extends Area2D

@onready var CoinSFX: AudioStreamPlayer = $CoinSFX
@onready var coins_label: Label = $"../CoinsCollected/CoinsLabel"
@onready var CoinIMG: TextureRect = $CoinImage

func _on_body_entered(body: Node2D) -> void:
	CoinSFX.play()
	CoinIMG.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	PlayerVariables.Coins += 1
	coins_label.text = str(PlayerVariables.Coins)
	await CoinSFX.finished
	queue_free()
