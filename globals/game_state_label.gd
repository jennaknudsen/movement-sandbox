extends Label
@export var player_character : CharacterBody2D = null

func _process(_delta):
    if player_character is PlayerCharacter:
        text = player_character.States.find_key(player_character.state)
