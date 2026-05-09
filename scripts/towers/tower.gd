extends Node2D

@export var fireRate: float = 1.0
@export var range: float = 150.0

var cooldown: float = 0.0
var target = null

@onready var area = $Area2D

func shoot():
	if target == null:
		return
	
	print("Firing...")
	target.takeDamage(1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Tower ready.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta
	
	if target and cooldown <= 0:
		shoot()
		cooldown = 1.0 / fireRate


func _on_area_2d_body_entered(body):
	if body.name == "Enemy":
		target = body


func _on_area_2d_body_exited(body):
	if body == target:
		target = null
