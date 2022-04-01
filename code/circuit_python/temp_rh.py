import time
import board
import busio # contains an interface for using hardware-driven I2C communication from your board

# board
import adafruit_hts221

i2c = busio.I2C(board.SCL1, board.SDA1)

hts = adafruit_hts221.HTS221(i2c)

# read the rel humidity and temp every second
while True:
    print("RH: %.2f %%" % hts.relative_humidity)
    print("Temp: %.2f C" % hts.temperature)
    print()
    time.sleep(1)
