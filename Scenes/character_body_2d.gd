extends CharacterBody2D

@export var SPEED: float = 400.0
@export var JUMP_FORCE: float = -400.0
@export var GRAVITY: float = 980.0
@export var DASH_DISTANCE: float = 1500.0
@export var DASH_DURATION: float = 0.2
@export var SPRINT_SPEED: float = 800.0

@onready var DeathSFX: AudioStreamPlayer = $DeathSFX

var is_floating: bool = false 
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_direction: float = 1.0
var current_speed: float
var has_jumped: bool = false

func _ready():
	if PlayerVariables.checkpoint != Vector2(0, 0):
		position = PlayerVariables.checkpoint

func get_input():
	if is_dashing:
		return
	velocity.x = Input.get_axis("left", "right") * current_speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
		has_jumped = true
	
	if Input.is_action_just_pressed("jump") and not is_on_floor() and has_jumped:
		is_floating = true
		print("Floating")
	
	if Input.is_action_just_released("jump"):
		is_floating = false
	
	if is_on_floor() and not Input.is_action_just_pressed("jump"):
		is_floating = false
		has_jumped = false

func DASH(delta):
	if Input.is_action_just_pressed("Dash") and not is_dashing:
		is_dashing = true
		dash_timer = DASH_DURATION
		dash_direction = sign(Input.get_axis("left", "right"))
		if dash_direction == 0:
			dash_direction = 1.0
	
	if is_dashing:
		velocity.x = DASH_DISTANCE * dash_direction
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false

func Sprint():
	if Input.is_action_pressed("Sprint"):
		current_speed = SPRINT_SPEED
	else:
		current_speed = SPEED

func _process(delta: float) -> void:
	Death()

func _physics_process(delta: float) -> void:
	if not is_on_floor() and not is_floating:
		velocity.y += GRAVITY * delta
	if is_floating:
		velocity.y = 0
	Sprint()
	get_input()
	DASH(delta)
	move_and_slide()

func Death():
	if PlayerVariables.Player_Health <= 0 and not PlayerVariables.is_dead:
		DeathSFX.play()
		PlayerVariables.is_dead = true
		PlayerVariables.Player_Health = 100
		PlayerVariables.is_dead = false
		get_tree().reload_current_scene()
		position = PlayerVariables.checkpoint