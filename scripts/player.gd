extends CharacterBody2D

@export var speed:=200


@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var camera:Camera2D = $Camera2D

func _ready():
	animated_sprite.animation =&"idle"
	camera.limit_bottom = get_viewport_rect().size.y
	

#maping direction to idle frame sprites
var idle_sprites:={Vector2.UP: 0, Vector2.RIGHT:1, Vector2.DOWN:2,Vector2.LEFT:3}

func handle_player_movement():
	var _direction = Vector2.ZERO
	var player_animation: StringName ="idle";	
	if(Input.get_action_strength("right") >0.0):
		_direction = Vector2.RIGHT
		player_animation = "run_right"
		idle_sprite_idx = Vector2.RIGHT
	elif(Input.get_action_strength("left")>0.0):
		_direction = Vector2.LEFT
		player_animation = "run_left"
		idle_sprite_idx = Vector2.LEFT
	elif Input.get_action_strength("up"):
		_direction = Vector2.UP
		player_animation = "run_up"
		idle_sprite_idx = Vector2.UP
	elif Input.get_action_strength("down"):
		_direction = Vector2.DOWN
		player_animation = "run_down"
		idle_sprite_idx = Vector2.DOWN
	velocity = speed*_direction
	
	if(velocity.length() >0):
		animated_sprite.animation = player_animation
		animated_sprite.play()
		move_and_slide()

	else:
		animated_sprite.pause()
		animated_sprite.animation =&"idle"
		animated_sprite.frame = idle_sprites[idle_sprite_idx]
	

var idle_sprite_idx = Vector2.DOWN;
func _physics_process(delta):
	if(!DialogueManager.is_dialogue_active):
		handle_player_movement()
	
	
