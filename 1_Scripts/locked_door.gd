extends StaticBody2D

var is_player_near: bool = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("interact"):
		if is_player_near:
			open_door()


func _on_area_of_interaction_area_entered(area: Area2D) -> void:
	print("you can open")
	is_player_near = true
	get_node("Interact").visible = true
	

func _attempt_open_door() -> void:
	if GlobalVars.key > 0:
		open_door()
	else: 
		print ("this door is locked")

func _on_area_of_interaction_area_exited(area: Area2D) -> void:
	print("you can't open")
	is_player_near = false
	get_node("Interact").visible = false
	get_node("Lock").visible = false
	
func open_door() -> void:
	if GlobalVars.key > 0:
		get_node("CollisionShape2D").disabled = true
		get_node("AreaOfInteraction").monitoring = false
		get_node("LightOccluder2D").visible = false
		$AnimationPlayer.play("door_open")
		$DoorOpening.play()
		GlobalVars.key -= 1
		get_node("Lock").visible = false
	else:
		get_node("Lock").visible = true
	
