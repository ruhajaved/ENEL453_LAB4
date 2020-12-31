# ENEL453_LAB4

## Introduction

### Problem Statement

Using the Intel MAX-10 FPGA, interfaced with a distance sensor and buzzer, design a target sensor. When a target is closer than 20 cm, the display should flash at an increasing rate as it is brought closer. The 10 board LEDs should also get brighter and the buzzer should buzz at a higher frequency as a target becomes closer in general. The system should also allow the user to to display the distance, voltage reading, or ADC moving average as a function of the target’s location (formatting included). In addition, there should be a RESET button and a HOLD button, which allows the user to hold the display value, with debounce effects filtered out.

### Project Objective

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

## Launch

In order to program the board, ensure that the distance sensor is connected to the board appropriately. 5V to the 5V connection on the board, GND to the GND connection on the board, and the VA0 connection to the lower unlabelled connection node on the board. Refer to "ENEL 453 Lab 3  v2.pdf" in the ENEL453_LAB3 repository for visuals. Likewise, ensure that the buzzer is connected to pin AB7, as shown in the document "ENEL 453 Lab 4  v1.pdf". Note that PB1 is configured as RESET and PB2 is configured at HOLD.

## Possible Improvements

Possible improvements for this project include:

1.	Improve the design to also hold the LED brightness and the buzzer frequency when the hold button is pressed. Currently, only the display value is held.
2.	Improve the LED brightness feature to take into consideration human perception of brightness. Currently, the LEDs operate on a 0%-100% duty cycle, when for the human eye, a 50% duty cycle is similar to a 100% duty cycle. Use a lookup table for this, rather than using the distance as the duty cycle, as done now. This will allow you to implement a non-linear relationship which is not expensive in hardware.
