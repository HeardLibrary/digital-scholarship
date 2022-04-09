# (c) 2022 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf 2022-04-08

import time
# Estimated time of flight, including recovery is less than 10 s with a B engine.
seconds_to_run = 120
measurements_per_second = 12.6 # determined emprically when running full speed, not imposed by sleep statement
#delay_time = 1/ measurements_per_second # time to delay between multiple measurements

# Set up "board" (QT Py RP2040)
import board
import busio # contains an interface for using hardware-driven I2C communication from your board

i2c = busio.I2C(board.SCL1, board.SDA1)

# Import library to flash LED
import neopixel
pixels = neopixel.NeoPixel(board.NEOPIXEL, 1)

# Code to use the built-in boot button on the board. Pressed is False (grounded)
import digitalio
#button = digitalio.DigitalInOut(board.BUTTON)
button = digitalio.DigitalInOut(board.D2)
button.switch_to_input(pull=digitalio.Pull.UP)

# LSM6DS33 6 DOF sensor board
from adafruit_lsm6ds.lsm6ds33 import LSM6DS33
from adafruit_lsm6ds import Rate, AccelRange, GyroRange
acc_gyro_sensor = LSM6DS33(i2c)

# barometric pressure sensor board
import adafruit_bmp280
bar_sensor = adafruit_bmp280.Adafruit_BMP280_I2C(i2c)

# Set the local air pressure, adjusted for sea level, in hectoPascals
# This value isn't very important in this case where it's the relative altitude that we care about.
bar_sensor.sea_level_pressure = 1011.1757554
print('Sea level air pressure set to:', bar_sensor.sea_level_pressure/10, 'kPa')

# See https://github.com/adafruit/Adafruit_CircuitPython_LSM6DS/blob/main/adafruit_lsm6ds/__init__.py for possible values

# Note: maximum accleration rates for B engines with our rocket estimated around 35 m/s^2. 
# With gravity producing acceleration in the opposite direction, the sensor could read up to 45 m/s^2.
# So the range needs to be 8G to measure the peak reading.
acc_gyro_sensor.accelerometer_range = AccelRange.RANGE_8G # allowed values are 2G, 4G, 8G, and 16G
print("Accelerometer range set to: %d G" % AccelRange.string[acc_gyro_sensor.accelerometer_range])

acc_gyro_sensor.gyro_range = GyroRange.RANGE_500_DPS
print("Gyro range set to: %d DPS" % GyroRange.string[acc_gyro_sensor.gyro_range])

# acc_gyro_sensor.accelerometer_data_rate = Rate.RATE_1_66K_HZ
# acc_gyro_sensor.accelerometer_data_rate = Rate.RATE_12_5_HZ
print("Accelerometer rate set to: %d HZ" % Rate.string[acc_gyro_sensor.accelerometer_data_rate])

# acc_gyro_sensor.gyro_data_rate = Rate.RATE_1_66K_HZ
print("Gyro rate set to: %d HZ" % Rate.string[acc_gyro_sensor.gyro_data_rate])

print()

# Program will do nothing until the button is pressed.
print('Press button to start data collection.')
while button.value: # button.value will be True when not pressed
    pass
    
# Flash LED three times red so we know something happened
for flash in range(3):
    pixels.fill((255, 0, 0))
    time.sleep(0.1)
    pixels.fill((0, 0, 0))
    time.sleep(0.1)

try:
    start_time = time.monotonic_ns()
    with open("/motion.csv", "w") as file_object: # use "w" to clear previous data and "a" to append new data to the end of the file
        file_object.write('seconds,alt,x_acc,y_acc,z_acc,x_gyro,y_gyro,z_gyro\n')
        #file_object.flush()
        for count in range(seconds_to_run * measurements_per_second):
            elapsed_time = (time.monotonic_ns() - start_time)/1000000000
            if count % 100 == 0:
                print(elapsed_time, 's')
            
            alt = bar_sensor.altitude

            xa = acc_gyro_sensor.acceleration[0]
            ya = acc_gyro_sensor.acceleration[1]
            za = acc_gyro_sensor.acceleration[2]

            xg = acc_gyro_sensor.gyro[0] - 0.058
            yg = acc_gyro_sensor.gyro[1] + 0.161
            zg = acc_gyro_sensor.gyro[2] + 0.053

            file_object.write(str(elapsed_time) + ',' + str(alt) + ',' + str(xa) + ',' + str(ya) + ',' + str(za) + ',' + str(xg) + ',' + str(yg) + ',' + str(zg) + '\n') # must convert numbers to strings if using the write method
            #file_object.flush() # writes the file buffer to the file after each datum is written to the buffer. Not necessary if the file closes
            #time.sleep(delay_time)
except OSError as e:
    if e.args[0] == 30:
        print('read-only error')
    else:
        print('error', e.args[0])
        
# Flash LED three times blue so we know it's done
for flash in range(3):
    pixels.fill((0, 0, 255))
    time.sleep(0.1)
    pixels.fill((0, 0, 0))
    time.sleep(0.1)

print('done')
