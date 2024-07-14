extends CharacterBody2D
class_name PlayerCharacter

const RUN_SPEED = 500.0
const JUMP_VELOCITY = -1400.0
const GRAVITY = 3000

var frames_jump_held = 0
var frames_since_being_on_floor = 0

var jump_action = Action.new(0.25)

enum States {
    IDLE,
    WALKING,
    JUMPSQUAT,
    AIRBORNE,
}

@export var state: States = States.IDLE

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
    $AnimationPlayer.play("RESET")
    jump_action.connect("startup_time_finished", jump)

func _physics_process(delta):
    # Add the gravity.
    if is_on_floor():
        state = States.IDLE
    else:
        velocity.y += GRAVITY * delta

    # Handle jump.
    if Input.is_action_just_pressed("jump") and _can_floor_jump():
        #emit_signal("is_jumping")
        state = States.JUMPSQUAT

    match state:
        States.JUMPSQUAT:
            jump_action.perform(delta)
        _:
            pass


    # Get the input direction and handle the movement/deceleration.
    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * RUN_SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, RUN_SPEED)

    move_and_slide()
    
func _can_floor_jump():
    return state != States.JUMPSQUAT and is_on_floor()

func jump():
    velocity.y = JUMP_VELOCITY
