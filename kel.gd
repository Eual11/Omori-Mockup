extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_in_range: bool = false
var messages: Array[String] = [
	"Hey!! Hilu, it me Kel! Eual asked me to deliver this gift for you",
	"He wants you to know that you are one of the best people he met in his life",
	"and it is totally fun to hang out with you all the time!",
	"You should know that you are a gift to this world, no one is like you!",
	"You can be passionate about things and be artistic as much as you like", 
	"You have people that adore and support you... hehe",
	"Me and Eual are one of them",
	"and Whenever you are faced with adversity, don't ever give up!",
	"Try and try and try! and never ever give up and...",
	"and You will acheive all of your dreams!",
	"Finally you will buy Eual many things like 3D printer",
	"Anyways, It was nice to meet you! goodbye, see you later"
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
