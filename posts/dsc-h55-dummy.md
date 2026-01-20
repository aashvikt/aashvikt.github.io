---
date: 2025-06-18
title: 2010s cybershot dummy battery
desc: I made a dummy battery to let me use my 2010 Sony DSC-H55 Cybershot camera with a power bank.
tags: hw camera
cats: misc
---
# Dummy NP-BG1
![dsc h55 lying lens-up on a shrub](./h55-wilderness.avif)

This is the Sony Cybershot DSC-H55. It's a 14-megapixel digital camera from 2010 with a maximum resolution of 4320 x 3240. It has a fixed screen and lens, making it small and portable. It can take nice photos, and it really does try to take videos when you ask it to.

![dsc h55 with LCD screen side showing](./h55-front.avif)
![dsc h55 with lens side showing](./h55-back.avif)

It's powered by NP-BG1 batteries:

![official sony np-bg1 battery](./sony-side.avif "1st-party NP-BG1")
![side view of the backside of an np-bg1 battery](./sony-back-side.avif "Li-ion...")
![back label of an np-bg1 battery showing all specifications](./sony-back.avif "3.6V, 910mAh, and 3.3-3.4Wh")

These run out quite fast and swapping between batteries on-the-go requires you to not only have replacements with you but also to set date, time, and locale settings at every boot. I decided to dismantle a Digitek battery to try making a "dummy battery" from its shell:

![components of dummy battery laid out for display](./parts.avif)

After taking out the Digitek cell, I put a protoboard in the frame and soldered on an XY-016 and a USB-C breakout (both heartlessly scavenged from a dead project) and soldered them uglily to the frame's contacts:

![soldered dummy battery lying on its side, ugly](./dummy.avif)
![completed dummy battery next to official sony](./dummy-sony.avif)

Surprisingly, despite all the extra bulging, it fit into the camera. Pulling it out was more difficult. The battery door, of course, can not close while the camera is plugged into power.

It was ugly, but after randomly trying a few different resistors on the "C" ("Communication"? Usually a thermistor, I'm guessing) pad between the anode and cathode, I managed to fool the camera into allowing itself to work with this battery in and powered by USB-C.

![all three batteries side by side, with the usb c port on the dummy showing prominently](./battery-family.avif)
![all three batteries side by side, with the misshapen molten contacts on the dummy showing prominently](./battery-family-evil.avif)

I'm sure you were able to spot mine :P