---
date: 2024-09-14
title: quick mc mod version switching from the shell
desc: A quick and easy shell script so many find themselves needing.
tags: sw shell games
cats: sw
---
# Fast Mod Switching from the Shell
If you're going to waste time, like I [sometimes do](https://en.wikipedia.org/wiki/Peer_pressure), playing __multiple versions__ of [a video game](https://en.wikipedia.org/wiki/Minecraft), with __different worlds__ each needing __different sets of mods__, why not make it effortless to switch between sets of mods?

Get yourself a dir, say, `~/Desktop/mc-mod-sets`. Make folders for each mod set and fill them:
```
(~/Desktop/mc-mod-sets)
.
├── mmorpg_mod_world
│   ├── mod_2061_v10.4.2.jar
│   ├── mod_3620_v10.4.2.1.jar
│   ├── mod_7358_v10.4.3.jar
│   ├── mod_7869_v10.4.2.jar
│   └── mod_9755_v10.4.2.2.jar
├── multiplayer_friend1
│   ├── mod_2474_v2.3.4.jar
│   ├── mod_7789_v2.3.4.1.jar
│   └── mod_9000_v2.3.4.jar
├── multiplayer_friend2
│   ├── mod_8692_v10.6.1.jar
│   └── mod_9023_v10.6.1.jar
├── old_legacy_version
│   ├── mod_1322_v1.0.2.jar
│   └── mod_8195_v1.0.3.jar
└── singleplayer_world
    ├── mod_1969_v8.0.1.jar
    └── mod_2435_v7.9.4.jar
6 directories, 25 files
```

Usually, you'd have to copy each of these by hand into your main Minecraft mod folder -- usually `~/.minecraft/mods` on Linux or `~/Library/Application Support/minecraft/mods` on Mac.

I've got a tiny shell script to do just that:

```sh
mods_dir="$HOME/.minecraft/mods"
mod_sets="$HOME/Desktop/mc-mod-sets"

echo "mc worlds:"
ls -d "$mod_sets"/*/ | awk '{print NR-1 ": " $0}'

read -p "mc world index: " set_index
set_name=$(ls -d "$mod_sets"/*/ | sed -n "$((set_index + 1))p")

rm $mods_dir/*
cp $set_name/* $mods_dir
echo "shifted to: $set_name"
```

It lists your mod sets, lets you input an index, and copies that one in. For example:

```m
souffle@soufz ~> ./mc-mod-switcher
mc worlds:
0: /home/souffle/Desktop/mc-mod-sets/mmorpg_mod_world/
1: /home/souffle/Desktop/mc-mod-sets/multiplayer_friend1/
2: /home/souffle/Desktop/mc-mod-sets/multiplayer_friend2/
3: /home/souffle/Desktop/mc-mod-sets/old_legacy_version/
4: /home/souffle/Desktop/mc-mod-sets/singleplayer_world/
mc world index: 
```

Say I'd like the mods I need to play `old_legacy version`:
```md
mc world index: **3**
shifted to: /home/souffle/Desktop/mc-mod-sets/old_legacy_version/
```

And it's done! If you want to check:
```
souffle@soufz ~> ls ~/.minecraft/mods
mod_1322_v1.0.2.jar  mod_5740_v1.1.0.jar  mod_7179_v5.0.7.jar  mod_8080_v10.6.9.jar  mod_8195_v6.0.1.jar
```

What can I say? It's a breeze!
