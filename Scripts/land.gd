extends Node2D

@onready var player = $Player

func _process(delta: float) -> void:
	Win_Condition()

func Win_Condition():
	if PlayerVariables.Coins >= 2 and not PlayerVariables.level_complete:
		PlayerVariables.level_complete = true
		PlayerVariables.levels_completed += 1
		PlayerVariables.Coins = 0
		PlayerVariables.level_complete = false
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://Scenes/Land2.tscn")
