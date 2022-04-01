import time
import board
import busio
import adafruit_vcnl4040

i2c = busio.I2C(board.SCL1, board.SDA1)
sensor = adafruit_vcnl4040.VCNL4040(i2c)

while True:
    print("Proximity:", sensor.proximity)
    print("Light: %d lux" % sensor.lux)
    print()
    # Use the following line for the plotter function
    #print( (sensor.lux,) ) # Force the data to be represented as a 1=tuple
    time.sleep(1)
