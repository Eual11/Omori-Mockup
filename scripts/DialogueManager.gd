
extends Node

static var is_dialogue_active := false
var dialogue_ui: Control


func _ready():
	var ui_scene = preload("res://scenes/dialogue_box.tscn")
	dialogue_ui = ui_scene.instantiate()
	get_tree().root.add_child.call_deferred(dialogue_ui)
	dialogue_ui.dialogue_finished.connect(_on_dialogue_finished)
	dialogue_ui.hide()

func start_dialogue(lines: Array[String], emotion_map:Dictionary ={}):
	if !is_dialogue_active:
		is_dialogue_active = true
		dialogue_ui.start_dialogue(lines, emotion_map)

func _on_dialogue_finished():
	is_dialogue_active = false
