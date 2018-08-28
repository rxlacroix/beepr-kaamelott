`beepr.kaamelott`: beepr avec du Kaamelott dedans
========================================================


Installation
----------------



```
library(devtools)
install_github("rxlacroix/beepr.kaamelott")
```

Requirements
---------------

If you are using Windows or OS X `beepr.kaamelott` relies on the `audio` package for sound playback and no external program is needed.

If you're on Linux `beepr` relies on you having either the `paplay` utility from the Pulse Audio system, the `aplay` utility from the ALSA system or [VLC media player](http://www.videolan.org/vlc/index.html) installed and on the PATH. Chances are that you alread have one of these. If you are on Debian/Ubuntu you can otherwise get VLC by running the following in a terminal:

```
sudo apt-get install vlc
```

Details
------------

`beep.kaamelott()` plays a short sound which is useful if you want to get notified, for example, when a script has finished. As an added bonus there are a number of different sounds to choose from.

### Usage

`beep(sound = 1, expr = NULL)`

### Arguments

`sound`  character string or number specifying what sound to be played by either specifying one of the built in sounds or specifying the path to a wav file. The default is 1. Possible sounds are:

1 => 36

If `sound` does not match any of the sounds above, or is a valid path, a random sound will be played.

`expr`	An optional expression to be executed before the sound.

### Examples

```
# Play a specific sound
beep.kaamelott(1)

# Play a random sound
beep.kaamelott(0)

# Play a sound if an error occurs
beepk_on_error(1 + "a", sound = "wilhelm")
```
