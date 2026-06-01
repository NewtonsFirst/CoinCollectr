extends Node2D

@onready var player = $Player


func _process(delta: float) -> void:
	switch_scene()

func switch_scene():
	if player.global_position.x > 1230:
		get_tree().change_scene_to_file("res://Scenes/land_3.tscn")
	
	if player.global_position.x < -60:
		get_tree().change_scene_to_file("res://Scenes/Land.tscn")
