extends Node2D

@export var maxHealth: int = 10
var currentHealth: int 

func _ready():
	currentHealth = maxHealth

func takeDamage(amount: int):
	currentHealth -= amount
	print("Enemy HP:", currentHealth)
	
	if currentHealth <= 0:
		die()

func die():
	queue_free()
