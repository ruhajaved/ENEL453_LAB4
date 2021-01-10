# ENEL453_LAB4

## Introduction

### Problem Statement

Using the Intel MAX-10 FPGA, interfaced with a distance sensor and buzzer, design a target sensor. When a target is closer than 20 cm, the display should flash at an increasing rate as it is brought closer. The 10 board LEDs should also get brighter and the buzzer should buzz at a higher frequency as a target becomes closer in general. The system should also allow the user to to display the distance, voltage reading, or ADC moving average as a function of the target’s location (formatting included). In addition, there should be a RESET button and a HOLD button, which allows the user to hold the display value, with debounce effects filtered out.

### Project Objective

The project objectives included:

1.	To gain experience with digital systems design, testing, and implementation.
2.	To introduce students to real-world FPGA applications, such as a target sensor.
3.	To give students a glimpse of what it means to be an engineer.

## Technologies

The technologies used include:

1. VHDL 1997
2. Intel Quartus Prime Lite Edition v20.1
3. ModelSim Intel FPGA Starter Edition
4. DE10-Lite FPGA board from Terasic
5. Sharp Distance Measuring Sensor Unit GP2Y0A41SK0F
6. A standard vibrating buzzer

## Solution

The following solution was implemented:

1.	Designed a hierarchical system optimized for hardware implementation, by re-using values/modules, as well as lookup tables, throughout the design.
2.	Implemented functionality to give the user the option to display the distance, voltage reading, or ADC moving average as a function of the target’s location (formatting included).
3.	Added functionality to hold the display value when a button was pressed, with an independent module used to filter out debounce effects.
4.	Using PWM modules, created appropriate driving signals for the LEDs, display, and buzzer as a function of distance.

## Launch

To launch the project on to the board, you will first have to create a project in Quartus. To do so follow these steps:

1. Select "New Project Wizard".
2. Click "Next" on the intro page.
3. Choose a directory for the project, as well as a name for the project. Set the top level name to "top_level.vhd" and click "Next".
4. Select "Empty Project" and click "Next".
5. Add all the project files (everything with extensions vhd., qsf., and .sdc). Also, add "adc_qsys.qip" in adc_qsys > synthesis. Click "Next".
6. Go into the "Board" tab and select "MAX 10 DE10-Lite". Also, make sure to unselect "Create top-level design file" that is located near the bottom of the window. Click "Next".
7. Include no EDA tools. Click "Next".
8. Click "Finish".

Then, to program the hardware, ensure that the distance sensor is connected to the board appropriately. 5V to the 5V connection on the board, GND to the GND connection on the board, and the VA0 connection to the lower unlabelled connection node on the board. Refer to "ENEL 453 Lab 3  v2.pdf" in the ENEL453_LAB3 repository for visuals. Likewise, ensure that the buzzer is connected to pin AB7, as shown in the document "ENEL 453 Lab 4  v1.pdf". Note that PB1 is configured as RESET and PB2 is configured at HOLD. Then follow these steps to program the hardware:

1. Compile the design. This can be done through a button on the taskbar.
2. Click on "Program Device".
3. Click on "Hardware Setup".
4. Slect "USB-Blaster" and then "Close".
5. Finally, click on "Start" and wait till the progress bar shows 100%. At this point the board has been programmed and you can test the design.

If looking to simulate the design, create a project in ModelSim. You can then use any of the different testbenches provided to test different parts of the design.

Also note that depending on if looking to test the design on the board vs simulate on ModelSim, you must comment out one of the lines from line 34-35 in "ADC_Data.vhd".

## Possible Improvements

Possible improvements for this project include:

1.	Improve the design to also hold the LED brightness and the buzzer frequency when the hold button is pressed. Currently, only the display value is held.
2.	Improve the LED brightness feature to take into consideration human perception of brightness. Currently, the LEDs operate on a 0%-100% duty cycle, when for the human eye, a 50% duty cycle is similar to a 100% duty cycle. Use a lookup table for this, rather than using the distance as the duty cycle, as done now. This will allow you to implement a non-linear relationship which is not expensive in hardware.
