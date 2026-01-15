---
2024-10-27
zippermau5, my micromouse
A post about ZIPPERMAU5, a WIP micromouse robot using a custom pcb, teensy 4.1, brushed dc motors, and time-of-flight sensors.
micromouse robotics pcb
rb gem
---
# zippermau5, micromouse robot

![software view of micromouse pcb](~/pcb.png)

## About
_ZIPPERMAU5_ is a [micromouse](https://en.wikipedia.org/wiki/micromouse) robot that I'm currently working on, and have been since around june of this year. Check out [the zippermau5 github](https://github.com/aashvikt/zippermau5)!

Here's a small list of this micromouse's features:

- a floodfill mazesolving algorithm, with open/closed maze tactic
- vl53 tOf sensors for maze sensing, with an mpu6050 imu for dead-reckoning
- teensy 4.1, programmed in cpp using the platformio framework
- a custom pcb, designed in easyeda, and manufactured by jlcpcb with assembly for small (lcsc) smd parts
- dual 1200rpm "n20" motors w/magnetic hall encoders
- drv8833 motor driver ic, but **__I FORGOT TO BREAK OUT THE MOTOR PINS!!1&!!#%!1&!!#$%__** FML
- a buzzer, 3 pushbuttons and 3 rgb leds for debugging/interaction
- a 25c 3.7v 850mAh lipo

I hope I'll take it to a competition some day!

## Update Log
- No progress on algorithm for while, going to get back to project soon
- PCB is here, and has been mostly assembled!
- Dumb me forgot to break out the main motor pins... that's the only mistake I've found.
- I do wish that I had made the pcb to let the ToF pins be like [this](~/better-tof.png) instead.
- I managed to solder four wires to the tiny TSSOP-16 drv8833, but they broke off... images in gallery, that soldering was impressive!
- Ended up adding an external drv8833 breakout board to the bottom of the board, as soldering big wires to smd is not reliable.
- Used the motors for a competition I didn't have enough time to prepare for, so am going to have to wait around three million days to get replacements... ¯\\\_(ツ)\_/¯
- 2025 is almost over, and I don't think I'll be picking this project back up due to the crippling hardware issue, lack of motivation and disgust at jank in something I'd wanted to be "perfect".

## Gallery
![front of micromouse pcb](~/front.png "Teensy, VL53s, IMU, buttons, lights, and mounts")
![back of micromouse pcb](~/back.png "The motor driver to replace the connections I forgot to break out")
![pro soldering on micromouse pcb](~/pro-solder.png "Some impressive soldering")