---
date: 2025-12-06
title: sonshi-style external keyboards with systemd
desc: I set up a python systemd service to disable my internal keyboard when an external one's connected.
tags: sw linux
cats: sw
---
# Using my Keyboard Sonshi-Style with systemd on Debian

For the past few months, I've been using a laptop given to me after Bitlocker bricked the first owner's Windows install that sadly wasn't associated with an Outlook account. No matter, I've got Debian running well on it, and I use it daily! It's become my primary computer, but I've run into a problem.

If you use an external keyboard which you place directly on top of your laptop's keyboard, [AKA using it Sonshi-style](https://xn--gckvb8fzb.com/sonshi-style-aka-keyboard-on-laptop "You might want to disable your javascript before clicking on this one..."), you're probably been annoyed by it accidentally pressing keys on the internal keyboard.

Since I refuse to forego this ergonomic and compact keyboard placement, I wrote a quick Python daemon to disable the internal keyboard when a specific external keyboard is connnected, and re-enable it when the external one is unplugged.

It runs as a session-idependent, Wayland-safe and always-on systemd service.

## The script

Here's the Python:
```py
#!/usr/bin/env python3

EXTERNAL = "/dev/input/by-id/*WT65-H2*-event-kbd"
INTERNAL = "/dev/input/by-path/platform-i8042-serio-0-event-kbd"

import fcntl,glob,time
G = 0x40044590
fd = None
while True:
    e=glob.glob(INTERNAL)
    if e and not fd:
        fd=open(EXTERNAL, "rb", 0)
        fcntl.ioctl(fd, G, 1)
    if not e and fd:
        fcntl.ioctl(fd, G, 0)
        fd.close()
        fd = None
    time.sleep(1)
```

It's a bit golfed, but here's how you make it work.

To find your external keyboard, list all input devices by ID:
```sh
ls -l /dev/input/by-id/
```
Look for entries matching `*-event-kbd`, and try it with your keyboard plugged and unplugged to confirm which keyboard is which.

I confirmed my results by running, for example, `sudo cat /dev/input/by-path/platform-i8042-serio-0-event-kbd` and pressing a few keys and watching for output or terminal noise. You'll know it when you see it, it's fun to watch.

Once you're sure, just set `EXTERNAL` and `INTERNAL` as I have near the top of the script:
```py
# by-path:
INTERNAL = "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
# using a wildcard to match it, just in case:
EXTERNAL = "/dev/input/by-id/*WT65-H2*-event-kbd"
```

That's all for the script. If you're interested how it actually works, in short, `fcntl.ioctl(fd, 0x40044590, 1)` sends an [`EVIOCGRAB`](https://unix.stackexchange.com/questions/126974) ioctl to the Linux input subsystem. `1` grabs te device exclusively (disables it at the source) and `0` releases the grab, re-enabling it.

The script is an infinite loop with `time.sleep(1)`. Hardly the most efficient or elegant, but it works fine, costing me maybe a couple minutes of CPU time over weeks of uptime.

The script also only acts for a specific external keyboard, so you can still plug in a different keyboard in case of an emergency.

I saved the script to `~/scripts/keyboard_auto_disable.py`, as `~/scripts` is in my path, and made it executable:
```sh
chmod +x ~/scripts/keyboard_auto_disable.py
```

And, to make sure it works:
```sh
python3 ~/scripts/keyboard_auto_disable.py
```

My keyboards are toggling correctly, so I make it run automatically. Making `/etc/systemd/system/keyboard-monitor.service`, a systemd service:
```ini
[Unit]
Description=Keyboard Auto Disable
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/env python3 /home/souffle/scripts/keyboard_auto_disable.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Reloading systemd:
```sh
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

Make it run at boot:
```sh
sudo systemctl enable keyboard-monitor.service
```

And start it now:
```sh
sudo systemctl start keyboard-monitor.service
```

We can see that it's working:
```sh
sudo systemctl status keyboard-monitor.service
```
... Gives:
```
● keyboard-monitor.service - Keyboard Auto Disable
     Loaded: loaded (/etc/systemd/system/keyboard-monitor.service; enabled; preset: enabled)
     Active: active (running) since Day 2025-12-06 HH:MM:SS UTC; N weeks O days ago
 Invocation: 6464ba056ef54931a1cbe47d7d8eb3df
   Main PID: 1911 (python3)
      Tasks: 1 (limit: 18738)
     Memory: 3.6M (peak: 11.8M, swap: 1.8M, swap peak: 1.8M)
        CPU: 2min 22.008s
     CGroup: /system.slice/keyboard-monitor.service
             └─1911 python3 /home/souffle/scripts/keyboard_auto_disable.py

Dec 29 HH:MM:SS soufz systemd[1]: Started keyboard-monitor.service - Keyboard Auto Disable.
```

Python PID visible!

![external keyboard sitting on top of laptop keyboard](/assets/jelly-star/sonshi-keyboard.avif)