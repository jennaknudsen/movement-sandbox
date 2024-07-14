extends Label
@export var player_character : CharacterBody2D = null

func _process(_delta):
    if player_character is PlayerCharacter:
        var state_str = player_character.States.find_key(player_character.state)
        var velocity_x = str(player_character.velocity.x)
        text = "State: " + state_str + " | X Velocity: " + velocity_x
