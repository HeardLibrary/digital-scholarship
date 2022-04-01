# Warning! This script flashes a light, so don't use if you are sensitive to that.

import time
import board
import neopixel

pixels = neopixel.NeoPixel(board.NEOPIXEL, 1)

while True:
    pixels.fill((255, 0, 0)) # red
    #pixels.fill((0, 255, 0)) # green
    #pixels.fill((0, 0, 255)) # blue
    time.sleep(0.1)
    pixels.fill((0, 0, 0))
    time.sleep(0.1)
