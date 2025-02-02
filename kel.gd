extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_in_range: bool = false
var messages: Array[String] = [
	"Whoa Dude, you are in Crow XI channel?!",
	"You are so cool, i want to be like you when i grow up!"
]

var emotion_map ={
	
	1:"happy",
}

func _on_area_2d_body_entered(body):
	player_in_range = true


func _on_area_2d_body_exited(body):
	player_in_range = false
	
func _input(event):
	if(player_in_range and event.is_action_pressed("ui_accept") and !DialogueManager.is_dialogue_active):
		DialogueManager.start_dialogue(messages, emotion_map)
		get_viewport().set_input_as_handled()
