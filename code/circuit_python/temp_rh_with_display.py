
import time
import board
import busio # contains an interface for using hardware-driven I2C communication from your board

# board
import adafruit_hts221

# display
import displayio
import adafruit_displayio_ssd1306
displayio.release_displays()
oled_reset = board.D9

i2c = busio.I2C(board.SCL1, board.SDA1)

display_bus = displayio.I2CDisplay(i2c, device_address=0x3c)
display = adafruit_displayio_ssd1306.SSD1306(display_bus, width=128, height=32)

hts = adafruit_hts221.HTS221(i2c)

# read the rel humidity and temp every second
while True:
    print() # this generates a newline to make up for the missing one at the end of the loop
    print() # this generates another newline to clear the text off the top of the display
    print("RH: %.2f %%" % hts.relative_humidity)
    print("Temp: %.2f C" % hts.temperature, end ="") # suppress newline to prevent text shifting up on display
    time.sleep(1)
