extends Label
@export var player_character : CharacterBody2D = null

func _process(_delta):
    if player_character is PlayerCharacter:
        var state_str = player_character.States.find_key(player_character.state)
        var velocity_x = str(player_character.velocity.x)
        var velocity_y = str(player_character.velocity.y)
        var pos_x = str(player_character.position.x)
        var pos_y = str(player_character.position.y)
        text = "State: " + state_str + " | X Velocity: " + velocity_x + " | Y Velocity: " + velocity_y + \
            "\nPosition: (" + pos_x + ", " + pos_y + ")"
