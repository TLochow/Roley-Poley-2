extends Node2D

var WheelsInGoal = 0

func _ready():
	$Intro/Tween.interpolate_property($Intro/Control, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 3.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Intro/Tween.start()

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
