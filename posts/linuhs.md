---
2023-11-05
linuhs: starting to follow lines
I made a line follower for a competition.
lfr robotics 3dp
rb
---
# Linuhs

This is to document experience till now with building a line following robot \[Linuhs\] and taking it to win a competition.

![robot view](~/linuhs.avif)

## hardware

The core of Linuhs was a WeAct Black Pill board (STM32f411CEU6), but an Arduino Nano could have easily handled the task.

Two N20 motors, driven by a DRV8833 motor driver, were rated for 1000rpm at 6V. Powered at the 9V I was supplying them, they could have been ran at higher speeds. The DRV8833 was unique in using the same pins for both PWM and direction control, unlike traditional brushed motor drivers.

For line following, I used an HY-S301 sensor array, which has 8 IR emitter-transistor pairs to detect ground color via reflected IR light. While often mislabelled online as a Pololu QTR sensor, it's a basic analog sensor with power, ground, enable, and 8 analog outputs.
Here's a picture of the hand-wired sensor array I made on a protoboard and originally intended on using before it broke:

![sensor array on protoboard](~/proto-sensor.avif)

The robot was powered by a 9V rechargeable battery and regulated to 3.3V for the MCU and sensors by an LM2596 buck converter.

## software

I used Platformio (w/ arduino hal) to code the STM32, as I had to be able to program on school computers. The robot calculates how far off it is from the line by checking which sensor is reading a black ground, and uses the error multiplied by a experimentally-derived constant ~(my jod, it's a technical document!)~ to adjust the current motor speeds to turn left or right.

## structure

A thin 3D-printed frame held the sensor array, protoboard, battery and motors mounts. This created a lightweight and robust-enough structure, but if I could I'd make the sensor area a lot thicker and change the screw holes to work better with the bolts I used. I designed the frame after sketching the dimensions in Fusion 360, and printed it on my Ender 5 Pro. `.stl` model and `.f3d` source on the [github repo](https://github.com/aashvikt/Linuhs/tree/main).

## testing

I had 2 tracks, both 4'x4', flex-printed. I made the designs myself, and they were very useful in tuning and preparing.

![robot following line track on floor](~/following.avif)

## competing

I took Linuhs to Exun, an interschool competition, where it competed against others' creations.
While my robot definitely had the most potential, advanced hardware, and unique design and the only non-AVR microcontroller at the competition, I know I haven't used them well and can't improve without completely disassembling the bot--something I don't want to do, as it could risk breaking my working, if mediocre, bot. Anyway, the judges were thoroughly impressed and I [came second](https://docs.google.com/document/d/1HpKa5A2AOPB4ArhohpBf7F20Kqb_J4NzRACcuJNZ5Fw/edit?tab=t.0#bookmark=id.c4oonn8p5joe).

## looking back and ahead

Some of my design choices had limited the robot's potential.
Now, with some more experience in line following, I'm going to be building a new robot from scratch. I am aiming to not only correct the mistakes of my first design but also create a more efficient and powerful line-following robot.

## specifically

Some ideas I want to incorporate into my next line follower are:

- PCB manufacturing and SMD assembly
- similar motors
- a sensor array wider than the motor 'track width' so as to not lose the line as easily
- longer robot to react fast to turns
- white LEDs with phototransistors to follow colorful lines, and colorful tracks for the same
- break detection, line search
- encoders on the motors, with the motors having their own PID speed-pwm control loop
- bluetooth for debugging and tuning
- neural network line classification?
- polyurethane robot wheels
- a **[lot](https://github.com/michalnand/motoko_uprising)** of **[the](https://github.com/michalnand/motoko_uprising_new)** ideas **[from](https://github.com/michalnand/motoko_ice_dragon)** michalnand's **[works](https://github.com/michalnand/motoko_ice_dragon_x)**

Hope you learnt something too!
