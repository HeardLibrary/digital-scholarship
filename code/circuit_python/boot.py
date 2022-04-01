import board
import digitalio
import storage

switch = digitalio.DigitalInOut(board.D0)
switch.direction = digitalio.Direction.INPUT
switch.pull = digitalio.Pull.UP

# Connecting D0 to ground makes switch.value False 
storage.remount("/", switch.value)
