extends CharacterBody2D



var player_in_range: bool = false
var messages: Array[String] = [
	"Hey Eual!!",
	"You see tired today",
	"Don't worry everything is gonna be okay!"
]

var emotion_map ={
	
	0:"happy",
	1:"happy",
	2:"happy",
	6:"happy",
	7:"angry",
	8:"angry",
	9:"happy",
	10:"goof",
	11:"happy"
	
	
}

func _on_area_2d_body_entered(body:Node):
	if(body.is_in_group("Player")):
		player_in_range = true


func _on_area_2d_body_exited(body:Node):
	if(body.is_in_group("Player")):
		player_in_range = false
	
func _input(event):
	if(player_in_range and event.is_action_pressed("ui_accept") and !DialogueManager.is_dialogue_active):
		DialogueManager.start_dialogue(messages, emotion_map)
		get_viewport().set_input_as_handled()
