---
2025-07-13
ds_store and dotfiles on mac and in finder
quickly stopping macos file-hell
mac sw dotfiles
sw
---
# Avoiding .DS_Store Dotfile-Hell
MacOS loves sprinkling hidden dotfiles in almost every folder, and, more annoyingly, in flash drives and networked discs. Thankfully, with a bit of work we can tame the filesystem to minimize the mess -- here's what I've done.

## in the bud

First, stop .DS_Store files from being created on network and USB stores:
```sh
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
```

Sadly, there's no way to disable .DS_Store creation on local directories of internal drives. We can, however, clean __them__[^1] with the `dot_clean` command. If you're not too sure about letting it run loose, running `dot_clean -nv` first will do a verbose dry run that shows you which files will be deleted before you go ahead with `dot_clean`.

## dandruff begone

We can automate this easily. To lock and load a script that cleans the current directory:
```sh
echo -e "#!/bin/sh\n/usr/sbin/dot_clean ." > ~/dotcleaner.sh
chmod +x ~/dotcleaner.sh
```
... You can now add it to Login Items in settings, to make it run at every login.
Alternatively, adding `alias cleanmac="dot_clean ~"` to your `.bashrc` or `.zshrc` makes a full sweeping pretty convenient too.

## handsfree degriming

If you don't log out often, running the script every time you spot a .DS_Store is still a pain, so we can automate it to run __periodically__[^2] with a cron job:
```sh
# open crontab editing:
crontab -e
# add this to make it run every hour:
0 * * * * /usr/sbin/dot_clean /Users/You/projects
```
... To regularly clean up, in this example, `~/projects`.

## git degunk

The greatest pain MacOS's dotfiles cause is seen in collaboration with other computers. Add this to your `.gitignore`s to avoid committing useless files to a project:
```
.DS_Store
.AppleDouble
.Spotlight-V100
.Trashes
._*
```

## finder convenience

That's pretty much all you need for a cleaner place, but while you're at it, since you're one to mess with dotfiles, you might as well enable the handy feature of showing hidden files (and hence also _dotfiles!_) in Finder:
```sh
defaults write com.apple.finder AppleShowAllFiles true
```
And toggle on showing full file paths:
```sh
defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE
```
... Ending with a Finder restart necessary to make things take effect:
```sh
killall Finder
```
And, if you don't like the change, run those same commands with `false` and `-bool FALSE` instead.

## hoorah

And that's it -- your Mac's a lot tidier, your drives less polluted, and your repos better protected from those vile files.

[^1]: dot_clean deletes more than .DS_Store files: it clears metadata, merging AppleDouble files like `._xyz`. It's not messed anything up for me so far, but take care!

[^2]: replacing that `0` with a `*` will make it run every minute, which should be pretty safe aside from adding to unnecessary disk I/O.
