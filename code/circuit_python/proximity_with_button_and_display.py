import time
import board
import busio
import digitalio
import adafruit_displayio_ssd1306
import adafruit_vcnl4040

# Use the following lines with the tiny 0.91" OLED display
oled_reset = board.D9

import displayio
displayio.release_displays()

# Set up board
i2c = busio.I2C(board.SCL1, board.SDA1)

display_bus = displayio.I2CDisplay(i2c, device_address=0x3c)
display = adafruit_displayio_ssd1306.SSD1306(display_bus, width=128, height=32)

sensor = adafruit_vcnl4040.VCNL4040(i2c)
button = digitalio.DigitalInOut(board.BUTTON)
button.switch_to_input(pull=digitalio.Pull.UP)

print('Press the BOOT')
print('button to start', end ="")
while button.value: # will be True when button not pressed
    pass

while True:
    print() # this generates a newline to make up for the missing one at the end of the loop
    print() # this generates another newline to clear the text off the top of the display
    print("Proximity:", sensor.proximity)
    print("Light: %d lux" % sensor.lux, end ="") # end argument suppresses newline from print
    time.sleep(1)
