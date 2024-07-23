extends CharacterBody2D
class_name PlayerCharacter
@export var animation_player : AnimationPlayer

const RUN_SPEED = 500.0
# character should get up to speed in 0.1 seconds
const TIME_TO_REACH_MAX_SPEED = 0.08
const JUMP_VELOCITY = -1400.0
const GRAVITY = 3000

var frames_jump_held = 0
var frames_since_being_on_floor = 0

var jump_action = TimedAction.new(0.075)

enum States {
    IDLE,
    WALKING,
    JUMPSQUAT,
    AIRBORNE,
    ON_WALL,
}

@export var state: States = States.IDLE

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
    animation_player.play("RESET")
    jump_action.connect("startup_time_finished", jump)

func _physics_process(delta):
    state = determine_state()

    # Add the gravity.
    if not is_on_floor():
        velocity.y += GRAVITY * delta
    is_on_wall()

    # Handle all inputs
    if Input.is_action_just_pressed("jump") and _can_floor_jump():
        #emit_signal("is_jumping")
        state = States.JUMPSQUAT
        animation_player.play("jump")

    # perform various actions based on state
    match state:
        States.JUMPSQUAT:
            jump_action.perform(delta)
        _:
            pass


    # Get the input direction and handle the movement/deceleration.
    var direction = Input.get_axis("move_left", "move_right")
    var horizontal_acceleration = RUN_SPEED * pow(TIME_TO_REACH_MAX_SPEED, -1)
    if direction:
        velocity.x = move_toward(velocity.x, RUN_SPEED * direction, horizontal_acceleration * delta)
    else:
        velocity.x = move_toward(velocity.x, 0, horizontal_acceleration * delta)

    move_and_slide()
    

func determine_state() -> States:
    # some states should "override" the state determining algorithm
    if state in [States.JUMPSQUAT]:
        return state
    elif is_on_floor():
        if velocity.x == 0:
            return States.IDLE
        else:
            return States.WALKING
    elif is_on_wall():
        return States.ON_WALL
    else:
        return States.AIRBORNE

func _can_floor_jump():
    return state != States.JUMPSQUAT and is_on_floor()

func jump():
    velocity.y = JUMP_VELOCITY
    state = States.AIRBORNE
