# Bizhawk Shuffler 2
* written by authorblues, inspired by [Brossentia's Bizhawk Shuffler](https://github.com/brossentia/BizHawk-Shuffler), based on slowbeef's original project
* [tested on Bizhawk v2.9.1-v2.10](https://github.com/TASVideos/BizHawk/releases/)
* [click here to download the latest version](https://github.com/AshenStrix/bizhawk-rpg-shuffler/archive/refs/heads/main.zip)
* Direct Encounter Shuffler links for those who already know what they are doing: [hash database](https://github.com/AshenStrix/bizhawk-rpg-shuffler/blob/main/plugins/encounter-shuffler-hashes.dat), [plugin](https://github.com/AshenStrix/bizhawk-rpg-shuffler/blob/main/plugins/rpg-encounter-shuffler.lua)

## Encounter Shuffler: Basics
* Get shuffled when you enter a battle in a supported game. Click on the hash database link above for the full list!
* Game highlights: Final Fantasy 1-9 and Lufia 2. More to come as development continues!
* Randomizers should be supported (e.g., FFV Career Day, FF6WC, FF6BC, etc.) by adding your game's hash to the .dat file alongside other versions of the game.
* The plugin can run simultaneously with the Mega Man Damage Shuffler and Chaos Shuffler.

## Encounter Shuffler: Setup
* First, [click here to download the latest version](https://github.com/AshenStrix/bizhawk-rpg-shuffler/archive/refs/heads/main.zip) of the main branch of this repo. This includes the Encounter Shuffler plugin and hash database.
* Next, follow the **[Setup Instructions](https://github.com/authorblues/bizhawk-shuffler-2/wiki/Setup-Instructions)** by authorblues, linked right there and/or at the [main repo](https://github.com/authorblues/bizhawk-shuffler-2).
* Finally, when you are setting up a run, **enable the Encounter Shuffler plugin** and follow the displayed instructions, including what to do with the shuffle timers.
* Be aware that, if you are including randomizers or romhacks, you will need to add hashes to the .dat file that correspond to the game that was modified. Just copy and paste a line from the corresponding game (e.g., Final Fantasy VI for FF6 Worlds Collide), replace the original hash with yours, and save. BizHawk or the shuffler should print the SHA-1 hash if it is missing from the .dat file.
* **TO THOSE PLAYING N64 GAMES: REMEMBER TO ENABLE THE EXPANSION PAK!**
* **TO THOSE PLAYING SEGA CD AND SEGA SATURN GAMES: YOU NEED BIZHAWK 2.10, MINIMUM!** I'll eventually require 2.10 and up.

## Encounter Shuffler: Thanks
* Thank you to everyone who laid the groundwork for this silly project: authorblues, Kalimag, Slowbeef, Phiggle, Brossentia, and everyone else. Any thanks Phiggle gave in his version of the shuffler this is forked from goes double from me, this absolutely wouldn't exist without all their work.