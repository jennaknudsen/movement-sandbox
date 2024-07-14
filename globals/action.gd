class_name Action
## A generic action that is performed after a specific duration.
signal startup_time_finished

func _init(duration: float) -> void:
    self._duration = duration

# time before action is performed, in seconds
var _duration: float

var _elapsed: float = 0.0

func perform(delta) -> void:
    _elapsed += delta
    if _elapsed >= _duration:
        # reset elapsed to 0 for next time this action is performed
        _elapsed = 0.0
        emit_signal("startup_time_finished") 