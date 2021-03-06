extends Node2D

export var open_width = 100
export var time_to_open_seconds = 1.0
export var initially_open = false

signal opened
signal closed

var current_time = 0.0
var opening = true

var left_door_initial_x = null
var right_door_initial_x = null

        
# Called when the node enters the scene tree for the first time.
func _ready():
    left_door_initial_x = $DoorLeft.position.x
    right_door_initial_x = $DoorRight.position.x
    
    if(initially_open):
        current_time = time_to_open_seconds
        open()
    else:
        current_time = 0.0
        close()
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if(opening):
        current_time = current_time + delta 
        current_time = clamp(current_time, 0, time_to_open_seconds)
    else:
        current_time = current_time - delta 
        current_time = clamp(current_time, 0, time_to_open_seconds)
    
    $DoorLeft.position.x = left_door_initial_x - (current_time / time_to_open_seconds) * open_width / 2.0
    $DoorRight.position.x = right_door_initial_x + (current_time / time_to_open_seconds) * open_width / 2.0
    
func open_or_close():
    if opening:
        close()
    else:
        open()
    
func open():
    opening = true
    emit_signal("opened")
    
func close():
    opening = false
    emit_signal("closed")
