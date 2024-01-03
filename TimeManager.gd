extends Node3D

#the time functions in hours
	#24 hours => a day
	#30 days => a month
	#12 months => a year
	#night and day needs to be its own node

@export var baseTime:int

@onready var MasterTimerRef = $MasterTimer

var currentHour = 0
var currentDay = 1
var currentMonth = 1
var currentYear = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	MasterTimerRef.wait_time = baseTime
	MasterTimerRef.start()
	MasterTimerRef.connect("timeout",Callable(self,"_on_MasterTimer_timeout"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_MasterTimer_timeout():
	incrementHour()
	print(MasterTimerRef.wait_time)

func incrementHour():
	if currentHour < 23:
		currentHour += 1
	else:
		currentHour = 0
		incrementDay()

func incrementDay():
	if currentDay < 30:
		currentDay += 1
	else:
		currentDay = 1
		incrementMonth()

func incrementMonth():
	if currentMonth < 12:
		currentMonth += 1
	else:
		currentMonth = 1
		incrementYear()

func incrementYear():
	currentYear += 1


func _on_pause_button_button_up():
	MasterTimerRef.set_paused(true)


func _on_play_1x_button_up():
	MasterTimerRef.set_paused(false) 
	MasterTimerRef.wait_time = baseTime

func _on_play_15x_button_up():
	MasterTimerRef.wait_time = baseTime / 2
	MasterTimerRef.set_paused(false) 
	

func _on_play_2x_button_up():
	MasterTimerRef.wait_time = baseTime / 3
	MasterTimerRef.set_paused(false) 
	
