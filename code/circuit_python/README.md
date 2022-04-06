# CircuitPython code resources

The code in this directory is to support a lesson series on programming an [QT Py RP 2040](https://www.adafruit.com/product/4900) microcontroller with [CircuitPython](https://circuitpython.org/). For more information, visit the [lesson series landing page](https://heardlibrary.github.io/digital-scholarship/script/python/circuit/).

To download any script, click on its file name, right-click on the `Raw` button, and select `Save as...`.

## Stand-alone Python scripts to load in the microcontroller

These scripts control devices or sensors connected to the QT Py board. Unless otherwise noted, their filenames need to be changed to `code.py` to be run on the board.

| script | device | notes |
|--------|--------|-------|
| led_flasher.py | neopixel LED on board |  |
| proximity.py | [VCNL 4040 proximity sensor](https://learn.adafruit.com/adafruit-vcnl4040-proximity-sensor/python-circuitpython) | detects light intensity and nearby objects |
| proximity_with_button.py | [VCNL 4040 proximity sensor](https://learn.adafruit.com/adafruit-vcnl4040-proximity-sensor/python-circuitpython) and BOOT button on board | modification of the previous script to trigger data collection when the BOOT button is pressed |
| proximity_with_button_and_display.py | [VCNL 4040 proximity sensor](https://learn.adafruit.com/adafruit-vcnl4040-proximity-sensor/python-circuitpython), BOOT button on board, and [0.91 in 128x32 px OLED display](https://www.adafruit.com/product/4440) | modification of previous script to also output to a tiny monochrome display |
| temp_rh.py | [HTS221 temperature and humidity sensor](https://www.adafruit.com/product/4535) |  |
| 
temp_rh_with_display.py | [HTS221 temperature and humidity sensor](https://www.adafruit.com/product/4535) and [0.91 in 128x32 px OLED display](https://www.adafruit.com/product/4440) | modification of previous script to also output to a tiny monochrome display |
| accel_gyro.py | [LIS3MDL+LSM6DS33 9 DoF inertial measurement unit sensor](https://www.adafruit.com/product/4485) | displays the gyroscope and accelerometer readings |
| accel_gyro_save_data.py | [LIS3MDL+LSM6DS33 9 DoF inertial measurement unit sensor](https://www.adafruit.com/product/4485) | modification of the previous script to save data on QT Py 8 MB memory chip; requires additional wiring and the `boot.py` script |
| rocket_script.py | [LIS3MDL+LSM6DS33 9 DoF inertial measurement unit sensor](https://www.adafruit.com/product/4485), neopixel LED on board, [BMP280 barometric pressure and altitude sensor](https://www.adafruit.com/product/2651) | modification of the script above to add altitude sensor and flash LED to indicate data collection has started |
| boot.py | none | script to control read/write state of onboard 8 MB memory; do not change name -- used in conjunction with `code.py` and an external switch |

## Jupyter notebooks (Python)

| script | notes |
|--------|-------|
| led_flasher.py | Reads data output from `rocket_script.py` and plots various measured quantities |
| MCP2221_Test.ipynb | experimental code to run STEMMA QT sensors directly from a laptop using the [MCP2221](https://www.adafruit.com/product/4471) USB to GPIO converter |

-----
Revised 2022-04-06
