extends Label
@export var player : CharacterBody2D = null

func _process(_delta):
    if player is Player:
        var state_str = player.States.find_key(player.state)
        var velocity_x = str(player.velocity.x)
        var velocity_y = str(player.velocity.y)
        var pos_x = str(player.position.x)
        var pos_y = str(player.position.y)
        text = "State: " + state_str + " | X Velocity: " + velocity_x + " | Y Velocity: " + velocity_y + \
            "\nPosition: (" + pos_x + ", " + pos_y + ")"
