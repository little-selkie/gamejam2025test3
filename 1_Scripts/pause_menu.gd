extends Control


func resume():
	get_tree().paused = false
	

func pause():
	get_tree().paused = true
	

func testEsc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_exit_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://0_Scenes/main_menu.tscn")

func _process(delta):
	testEsc()
