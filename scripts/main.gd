extends Node2D

@export var baseHealth: int = 10

func damageBase(amount: int):
	baseHealth -= amount
	print("Base health:", baseHealth)
	
	if baseHealth <= 0:
		print("Mission failed.")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_path_follow_2d_reached_end() -> void:
	pass # Replace with function body.
