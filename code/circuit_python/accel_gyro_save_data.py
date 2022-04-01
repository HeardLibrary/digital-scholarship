# Note: this script does not have the timing worked out. 
# See the rocket script where times have been worked out more accurately.
# This script is more about showing how to save the data to a file.

import time
seconds_to_run = 5
measurements_per_second = 10
delay_time = 1/ measurements_per_second # time to delay between multiple measurements

# Set up "board" (QT Py RP2040)
import board
import busio # contains an interface for using hardware-driven I2C communication from your board

i2c = busio.I2C(board.SCL1, board.SDA1)

# Code to use the built-in boot button on the board. Pressed is False (grounded)
import digitalio
button = digitalio.DigitalInOut(board.BUTTON)
button.switch_to_input(pull=digitalio.Pull.UP)

# LSM6DS33 6 DOF sensor board
from adafruit_lsm6ds.lsm6ds33 import LSM6DS33
from adafruit_lsm6ds import Rate, AccelRange, GyroRange
sensor = LSM6DS33(i2c)

# LIS3MDL 3 axis magnetometer board
import adafruit_lis3mdl
mag_sensor = adafruit_lis3mdl.LIS3MDL(i2c)

# See https://github.com/adafruit/Adafruit_CircuitPython_LSM6DS/blob/main/adafruit_lsm6ds/__init__.py for possible values

sensor.accelerometer_range = AccelRange.RANGE_16G # allowed values are 2G, 4G, 8G, and 16G
print("Accelerometer range set to: %d G" % AccelRange.string[sensor.accelerometer_range])

#sensor.gyro_range = GyroRange.RANGE_2000_DPS
print("Gyro range set to: %d DPS" % GyroRange.string[sensor.gyro_range])

#sensor.accelerometer_data_rate = Rate.RATE_1_66K_HZ
# sensor.accelerometer_data_rate = Rate.RATE_12_5_HZ
print("Accelerometer rate set to: %d HZ" % Rate.string[sensor.accelerometer_data_rate])

#sensor.gyro_data_rate = Rate.RATE_1_66K_HZ
print("Gyro rate set to: %d HZ" % Rate.string[sensor.gyro_data_rate])

print()

# Program will do nothing until the button is pressed.
print('Press "BOOT" button on board to start data collection.')
while button.value: # button.value will be True when not pressed
    pass

try:
    start_time = time.monotonic_ns()
    with open("/motion.csv", "w") as file_object: # use "w" to clear previous data and "a" to append new data to the end of the file
        file_object.write('seconds,x_acc,y_acc,z_acc,x_gyro,y_gyro,z_gyro\n')
        file_object.flush()
        for count in range(seconds_to_run * measurements_per_second):
            if count % measurements_per_second == 0:
                print(count / measurements_per_second)
            measure_time = time.monotonic_ns()
            xa = sensor.acceleration[0]
            ya = sensor.acceleration[1]
            za = sensor.acceleration[2]

            xg = sensor.gyro[0] - 0.058
            yg = sensor.gyro[1] + 0.161
            zg = sensor.gyro[2] + 0.053

            file_object.write(str((measure_time - start_time)/1000000000) + ',' + str(xa) + ',' + str(ya) + ',' + str(za) + ',' + str(xg) + ',' + str(yg) + ',' + str(zg) + '\n') # must convert numbers to strings if using the write method
            file_object.flush() # writes the file buffer to the file after each datum is written to the buffer. Not necessary if the file closes
            time.sleep(delay_time)
except OSError as e:
    if e.args[0] == 30:
        print('read-only error')
    else:
        print('error', e.args[0])
        
print('done')
