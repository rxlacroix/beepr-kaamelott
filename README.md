`beepr.kaamelott`: beepr avec du Kaamelott dedans
========================================================

L'entièreté de l'intelligence derrière ce package revient à https://github.com/rasmusab/beepr.



Installation
----------------


```
devtools::install_github("rxlacroix/beepr.kaamelott")
```

Exigences
---------------

Si vous utilisez Windows ou OS X `beepr.kaamelott` fait appelle au package `audio` pour jouer des sons et aucun programme externe n'est nécessaire.

Si vous êtes un utilisateur de Linux `beepr.kaamelott` a besoin que vous ayez soit l'utilitaire `paplay` du système Pulse Audio, soit l'utilitaire `aplay` du système ALSA ou[VLC media player](http://www.videolan.org/vlc/index.html) installé et dans le PATH. Il y a de fortes chances que vous en ayez déjà une des solutions. Si vous êtes sous Debian/Ubuntu, vous pouvez obtenir VLC en exécutant ce qui suit dans un terminal :

```
sudo apt-get install vlc
```

Détails
------------

`beep.kaamelott()` joue une réplique de Kaamelott ce qui est parfaitement adapté si vous voulez être informé de la plus belle des façons, par exemple quand un script se termine, ou tourne mal.  

### Utilisation

`beep.kaamelott(sound = 1, expr = NULL)`

### Arguments

`sound`  est un nombre spécifiant quel son doit être joué en référence à un fichier son .wav précis. Comme il y a 36 sons, l'argument peut aller de 1 à 36.


Si `sound` ne correspond pas à un bon argument, une réplique est tirée au sort.


### Examples

```
# Jouer une réplique spécifique
beep.kaamelott(22)

# Avoir une réplique au hasard
beep.kaamelott(0)

# Quand un script se termine
.
.
.
plot(x,y)
beep.kaamelott(33) # ou beep.kaamelott(31) ou beep.kaamelott(24) 

# Quand une erreur survient

beepk_on_error(fonction(poulette), sound = 27)
```
