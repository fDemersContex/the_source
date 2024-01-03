extends Node3D

var current_time_of_day = 0
var is_daytime = true

@onready var dayNightTimer = $DayNightTimer

func _ready():
	dayNightTimer.start()
	dayNightTimer.connect("timeout",Callable(self,"_on_DayNightTimer_timeout"))
	
func _process(delta):
	print("is_daytime:",is_daytime)
	
func _on_DayNightTimer_timeout():
	# Toggle between day and night
	if is_daytime:
		# Change to night
		is_daytime = false
		# Update game world to nighttime
	else:
		# Change to day
		is_daytime = true
		# Update game world to daytime
