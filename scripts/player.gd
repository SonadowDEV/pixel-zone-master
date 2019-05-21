extends KinematicBody2D
const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED = 250 # pixels/sec
const JUMP_SPEED = 500
const SIDING_CHANGE_SPEED = 10
const BULLET_VELOCITY = 1000
const SHOOT_TIME_SHOW_WEAPON = 0.2
const TIMER_LIMIT = 2.0
var timer = 0.0
var linear_vel = Vector2()
var onair_time = 0 #
var teleport_destination
var on_floor = false
var shoot_time=99999 #time since last shot
var default_weapon = preload("res://scenes/bullet.tscn").instance()
var weapon_current = default_weapon
var weapon_up = preload("res://scenes/bullet_modified.tscn").instance()
var anim=""
onready var sprite = $sprite
onready var respawn_position
func _ready():
	$ui/Control/GameUI.connect("FPSHide", self, "_on_fps_hide")
	$ui/Control/GameUI.connect("FPSShow", self, "_on_fps_show")
	respawn_position = position
	$"/root/game_health".points == 0
	$ui/AnimationPlayer.play("saving_state")
func _physics_process(delta):
	if Input.is_action_just_pressed("console"):
		if $console/console.visible == false:
			$console/console.show()
		if $console/console.visible == true:
			$console/console.hide()
	if $ui/Control/ProgressBar.value == 0:
		get_tree().change_scene("scenes/GameOver.tscn")
	onair_time += delta
	shoot_time += delta

	### MOVEMENT ###

	# Apply Gravity
	linear_vel += delta * GRAVITY_VEC
	# Move and Slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect Floor
	if is_on_floor():
		onair_time = 0

	on_floor = onair_time < MIN_ONAIR_TIME

	### CONTROL ###

	# Horizontal Movement
	var target_speed = 0
	if Input.is_action_pressed("move_left"):
		target_speed += -1
	if Input.is_action_pressed("move_right"):
		target_speed +=  1
	if Input.is_action_pressed("speed") and Input.is_action_pressed("move_left"):
		target_speed += -1.1
	if Input.is_action_pressed("speed") and Input.is_action_pressed("move_right"):
		target_speed += 1.1
	target_speed *= WALK_SPEED
	linear_vel.x = lerp(linear_vel.x, target_speed, 0.1)

	# Jumping
	if on_floor and Input.is_action_just_pressed("jump"):
		linear_vel.y = -JUMP_SPEED
		$sound_jump.play()
	# Shooting
	if Input.is_action_just_pressed("shoot"):
		var weapon_up = preload("res://scenes/bullet_modified.tscn").instance()
		var default_weapon = preload("res://scenes/bullet.tscn").instance()
		var weapon_current = default_weapon
		if $"/root/game_health".points == 1:
			weapon_current = weapon_up
		weapon_current.position = $sprite/bullet_shoot.global_position #use node for shoot position
		weapon_current.linear_velocity = Vector2(sprite.scale.x * BULLET_VELOCITY, 0)
		weapon_current.add_collision_exception_with(self) # don't want player to collide with bullet
		get_parent().add_child(weapon_current) #don't want bullet to move with me, so add it as child of parent
		$sound_shoot.play()
		shoot_time = 0

	### ANIMATION ###

	var new_anim = "idle"

	if on_floor:
		if linear_vel.x < -SIDING_CHANGE_SPEED:
			sprite.scale.x = -1
			new_anim = "run"

		if linear_vel.x > SIDING_CHANGE_SPEED:
			sprite.scale.x = 1
			new_anim = "run"
	else:
		# We want the character to immediately change facing side when the player
		# tries to change direction, during air control.
		# This allows for example the player to shoot quickly left then right.
		if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
			sprite.scale.x = -1
		if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			sprite.scale.x = 1

		if linear_vel.y < 0:
			new_anim = "jumping"
		else:
			new_anim = "falling"

	if shoot_time < SHOOT_TIME_SHOW_WEAPON:
		new_anim += "_weapon"

	if new_anim != anim:
		anim = new_anim
		$anim.play(anim)
		
func weapon_up():
	$ui/Control/ProgressBar.set_value(100)
	$anim2.play("full_health")
func health50():
	$ui/Control/ProgressBar.value += 50
func _on_Area2D2_area_entered(area):
	if area.name == "next_level":
		$ui/AnimationPlayer.play("next_level")
	if area.name == "enemyarea":
		$ui/Control/ProgressBar.value -= 3
	if area.name == "bossarea":
		$ui/Control/ProgressBar.value -= 3
func _on_stage2_normal_achieve1():
    $anim2.play("achievement")
func _on_Timer_timeout():
    $ui/Panel.hide()
func set_player_name(new_name):
	get_node("label").set_text(new_name)
func save():
	var node_data = {
				"filename" : get_filename()
	}
	return node_data
func _on_ice_cap1_achieve3():
	$anim.play("achievement")
func dd():
	$ui/Control/ProgressBar.value -= 70
func set_respawn(p):
	respawn_position = p
func teleport(destination):
	teleport_destination = destination
	$ui/Control/ProgressBar.set_value(100)
	$anim2.play("respawn")

func do_teleport():
	position = teleport_destination
func _process(delta):
    timer += delta
    if timer > TIMER_LIMIT: # Prints every 2 seconds
        timer = 0.0
        $ui/Control/fps.set_text("FPS: " + str(Engine.get_frames_per_second()))

func respawn():
	teleport(respawn_position)
func _on_fps_show():
	$ui/Control/fps.show()
func _on_fps_hide():
	$ui/Control/fps.hide()