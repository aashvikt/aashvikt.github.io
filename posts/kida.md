---
2022-03-22
kida: to make a quadruped
A post about a janky robotic insect I made.
robotics insect quadruped
rb gem
---
# Killer Insect Droid Automation, or KIDA

![robot insect side view](~/kida.avif)

I built a small (~~groundbreaking masterpiece~~) robot called KIDA. It's a quadruped with some fun inspiration from [Martedi's Walter Photovore](https://www.hackster.io/studikasus/walter-the-arduino-photovore-insect-708207) and [BEAM robotics](http://solarbotics.net). The base is a power bank, and it's powered by 5 MG90 servos - one for each leg and one to rotate the hip of the hind leg. I used an Arduino Nano and HC05 Bluetooth module mounted on a breadboard.

The legs are made from cut-up coat hangers bent to shape, with hot glue as feet. Everything's held together with different types of glue - lots of hot glue, some MSeal to attach the legs to the motors, and even a phone holder for the hip (truly the finest of materials). It's not pretty, but I was happy to see it work with the gait I designed!

For a sneak peek at the droid in action, please indulge in the video below. I promise, it's every bit as mesmerizing as you'd expect.

<iframe width="480" height="270" src="https://www.youtube.com/embed/_RdcMdsxoMY" allow="clipboard-write; encrypted-media; picture-in-picture; web-share" allowfullscreen></iframe>

Now that I have a 3d printer, I'm working on making another quadruped. A 12dof quadruped with servo actuators, inspired by the Petoi robots. Here's a preview of the protoboard I just soldered together for the power distribution and voltage regulation for the servos and microcontroller:

![proto board with soldered wires](~/12dof-proto.avif)

It might not look like much right now, but just wait till there's a hundred scuttling towards you. 

;)
