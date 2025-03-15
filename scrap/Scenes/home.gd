extends Node2D
#pissed off code 
#OS.execute("C:\\Users\\Computer\\Documents\\opencomd.exe", [], [], false, true)

#personal space
#window out of focus (window is focused false)
#crashed
@onready var panda = $Area2D/panda
@onready var timer = $Timer
var mode = 0
var ending_go = false
var thirstevent = false
var hungerevent = false
var hunger = 100
var thirst = 100
var hate = 0
var mood = 100


func _process(delta: float) -> void:
	if DisplayServer.window_is_focused() == false:
		panda.play("deathguy")
		hate += 0.1
	
	mood = max(-50, ((hunger + thirst)/2)) - hate*5
	if mood >= 0:
		$goodBar.value = mood
	else:
		$badBar.visible = true
		$goodBar.visible = false
		$badBar.value = abs(mood)
	if ending_go == false:
		if thirst == 0:
			if thirstevent == false:
				panda.play("dried")
				$AudioStreamPlayer2D.play()
				thirstevent = true
				
		if hunger == 0:
			if hungerevent == false:
				panda.play("dried")
				$starving.play()
				hungerevent = true
				
		if mood < 10 and mood > 0:
			panda.play("angry")

		if mood < -100:
			ending(ending_go)
			ending_go = true
		if panda.is_playing() == false:
			panda.play("default") 


func _on_water_button_button_down() -> void:
	hunger = min(hunger+5, 100) 
	
func _on_food_button_button_down() -> void:
	hunger = min(thirst+5, 100) 

func _on_timer_timeout() -> void:
	hunger = max(hunger-randf()*8, 0)
	thirst = max(thirst-randf()*4, 0) 
	timer.start()
	
func _on_area_2d_mouse_entered() -> void:
	hate += 2
	panda.play("chomp_talk")
	
func ending(run):
	if run == false:
		$backgroundmusic.stop()
		panda.play("blink")
		$backgroundmusic.volume_db = -80
		$Timer2.start(3)
	


func _on_timer_2_timeout() -> void:
	OS.execute("C:\\Users\\Computer\\Documents\\opencomd.exe", [], [], false, true)
