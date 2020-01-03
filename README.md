# Tales of Maj'Eyal (tome4) Guix Channel

A collection of custom Guix recipes that will install
[Tales of Maj'Eyal DLC](https://te4.org/tome/dlc) acquired from
[GOG.com](https://www.gog.com/).

# Usage

You need to get a copy of each DLC and place them inside your
$HOME/Downloads user's directory:
- https://www.gog.com/game/tales_of_majeyal_ashes_of_urhrok
- https://www.gog.com/game/tales_of_majeyal_embers_of_rage
- https://www.gog.com/game/tales_of_majeyal_forbidden_cults

After that you could clone this repository and install
tome4-with-addons Guix package:
``` shell
git clone https://gitlab.com/wigust/guix-tome4
GUIX_PACKAGE_PATH=$PWD/guix-tome4 guix install tome4-with-addons
```
