import time
delay_time = 0.1 # time to delay between multiple measurements

# Set up "board" (QT Py RP2040)
import board
import busio # contains an interface for using hardware-driven I2C communication from your board

i2c = busio.I2C(board.SCL1, board.SDA1)

# LSM6DS33 6 DOF sensor board
from adafruit_lsm6ds.lsm6ds33 import LSM6DS33
from adafruit_lsm6ds import Rate, AccelRange, GyroRange
sensor = LSM6DS33(i2c)

# See https://github.com/adafruit/Adafruit_CircuitPython_LSM6DS/blob/main/adafruit_lsm6ds/__init__.py for possible values

sensor.accelerometer_range = AccelRange.RANGE_4G # allowed values are 2G, 4G, 8G, and 16G
print("Accelerometer range set to: %d G" % AccelRange.string[sensor.accelerometer_range])

sensor.gyro_range = GyroRange.RANGE_500_DPS
print("Gyro range set to: %d DPS" % GyroRange.string[sensor.gyro_range])

# sensor.accelerometer_data_rate = Rate.RATE_1_66K_HZ
# sensor.accelerometer_data_rate = Rate.RATE_12_5_HZ
print("Accelerometer rate set to: %d HZ" % Rate.string[sensor.accelerometer_data_rate])

# sensor.gyro_data_rate = Rate.RATE_1_66K_HZ
print("Gyro rate set to: %d HZ" % Rate.string[sensor.gyro_data_rate])

print()

while True: # uncomment to capture one measurement
# while True: # uncomment for infinite loop
# for count in range(10): # uncomment for 10 measurements
    xa = sensor.acceleration[0]
    ya = sensor.acceleration[1]
    za = sensor.acceleration[2]

    # gyro has calibrations for zero rotation added
    xg = sensor.gyro[0] - 0.058
    yg = sensor.gyro[1] + 0.161
    zg = sensor.gyro[2] + 0.053

    print( (xa, ya, za) ) # Use this line to plot acceleration.
    #print( (xg, yg, zg) ) # Use this line to plot rotation.
    time.sleep(delay_time)
