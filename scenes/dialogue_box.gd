extends CanvasLayer


signal dialogue_finished
@export var sfx_list: Array[AudioStream] =[]
@onready var audio_player = $DialogueBox/AudioStreamPlayer
var current_line := 0
var messages: Array[String] = []
var emotion_map: Dictionary ={}

func _ready():
	$DialogueBox/PlayerImgContainer/BG/AnimatedSprite2D.play()
func start_dialogue(message_array: Array[String],  em_map:Dictionary):
	messages = message_array
	emotion_map = em_map
	current_line = 0
	show()
	update_dialogue()

func play_random_sfx():
	var rand_straem = sfx_list[randi()%sfx_list.size()]
	audio_player.stream = rand_straem
	audio_player.play()


func update_player_image():
	if(current_line in emotion_map):
		$DialogueBox/PlayerImgContainer/BG/AnimatedSprite2D.animation =emotion_map[current_line]
	else:
		$DialogueBox/PlayerImgContainer/BG/AnimatedSprite2D.animation ="neutral"

func update_dialogue():
	$DialogueBox/DialogueContainer/MarginContainer/DialogueText.text = messages[current_line]
	update_player_image()
	play_random_sfx()
	$DialogueBox/hand.hide()
	$DialogueBox/AnimationPlayer.play("typewriter_effect")

func _input(event: InputEvent):
	if visible and event.is_action_pressed("ui_accept"):
		current_line += 1
		if current_line < messages.size():
			update_dialogue()
		else:
			hide()
			dialogue_finished.emit()
		get_viewport().set_input_as_handled()


func _on_animation_player_animation_finished(anim_name):
	if(anim_name == "typewriter_effect"):
		audio_player.stop()
		$DialogueBox/hand.show()
		$DialogueBox/AnimationPlayer.play("hand")
