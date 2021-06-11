extends Node2D

var WheelsInGoal = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneChanger.EndGame()
	elif event.is_action_pressed("Restart"):
		SceneChanger.LoadLevel()

func _on_Goal_body_entered(body):
	WheelsInGoal += 1
	if WheelsInGoal >= 2:
		SceneChanger.NextLevel()

func _on_Goal_body_exited(body):
	WheelsInGoal -= 1

func _on_DeathPlane_body_entered(body):
	SceneChanger.LoadLevel()
