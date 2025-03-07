extends CharacterBody2D

@export var player_speed = 300
@export var acceleration = 10000
@export var friction = 10000

@onready var axis = Vector2.ZERO

var was_hit: bool = false

func _physics_process(delta):
	move(delta)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
	else:
		apply_movement(axis * acceleration * delta)
	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(player_speed)

func _on_health_collision_area_entered(area: Area2D) -> void:
	if !was_hit:
		was_hit = true
		if GlobalVars.player_health == 0:
			print("u ded")
		else:
			GlobalVars.player_health -= 1
			print(GlobalVars.player_health)
			if GlobalVars.player_health == 0:
				print("u ded")
	else:
		print("something buggy idk")


func _on_health_collision_area_exited(area: Area2D) -> void:
	was_hit = false
