---
2021-12-25
carros: teaching motor driving and arduino
Three simple robot cars for learning.
robotics
rb
---
# Carros, Carros-Obstacle, and Carros-BT
Arduino is one of the most common platforms used to teach beginner robotics, with its easy-to-understand use of C, wide hardware compatibility, and intuitive abstractions allowing one to quickly get started making projects, whether self-taught or with an instructor, before, if ever, moving on to something more low-level and fast.

Two-wheeled car robots are a great way to introduce robotics concepts to learners. They are easy to understand while offering many possibilities for expansion and modification depending on interest of the learner. The simplicity of the two-wheeled design allows beginners to learn about h-bridges, motor control, sensor integration, and basic programming skills that are foundational for more complex robotics projects.

I created three different variation of the classic robotic car to showcase a basic robot concept and provide a practical experience.

You can view the source code and video links [**here**](https://github.com/aashvikt/Carros).

## Carros
The first project is a basic battery-powered two-wheeled robot, which serves as an introduction to motor driving. This robot relies on an Arduino Uno to control the two DC motors that power its wheels. Using a simple motor driver, the car is able to move forward, backward, and turn left or right based on the input signals from the Arduino, showing how the basic movements of a robot are achieved through actuators.

## Carros-Obstacle
The second robot switches to an Arduino Pro Mini, programmed using an FTDI UART adapter. This version adds more functionality with obstacle avoidance. It uses an HC-SR04 ultrasonic sensor mounted on a servo motor, the robot can detect obstacles in its path and take action to avoid them, favoring forward, then left, then right, and lastly backward movement. This is a basic demonstration of integration of additional forms of actuation and sensor into a robot.

## Carros-BT
The third version is a Bluetooth-controlled car that can be operated directly from a smartphone. It uses an HC-05 Bluetooth module, which receives commands from the smartphone via an app, changing speed and direction in different ways.
