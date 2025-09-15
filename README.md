# Bizhawk Shuffler 2
* written by authorblues, inspired by [Brossentia's Bizhawk Shuffler](https://github.com/brossentia/BizHawk-Shuffler), based on slowbeef's original project
* [tested on Bizhawk v2.6.3-v2.10](https://github.com/TASVideos/BizHawk/releases/)  
* [click here to download the latest version](https://github.com/Phiggle/bizhawk-shuffler-2/archive/refs/heads/main.zip) - I do my best to keep up with the [main shuffler repo](https://github.com/authorblues/bizhawk-shuffler-2) but you may want to double-check.
* Direct Chaos Shuffler links for those who already know what they are doing: [hash database](https://github.com/Phiggle/bizhawk-shuffler-2/blob/main/plugins/chaos-shuffler-hashes.dat), [plugin](https://github.com/Phiggle/bizhawk-shuffler-2/blob/main/plugins/chaos-damage-shuffler.lua) (click on the plugin for instructions and a list of supported games!)

## Chaos Damage Shuffler: Basics
* Get shuffled when your character takes damage in a variety of games and senses. Click on the plugin link above for the full list!
* Game highlights: several games from the Battletoads, Mario, Metroid, Legend of Zelda, and Castlevania series, as well as Super Mario Kart, F-Zero, and some "wait, this shuffles?" nonsense like Anticipation (NES), Family Feud (SNES), Monopoly (NES), and much more.
* Infinite lives are generally supported.
* Multiplayer shuffling is generally supported.
* Randomizers should be supported (e.g., ALTTPR, VARIA, ZOoTR, SMZ3) by adding your game's hash to the .dat file alongside other versions of the game.
* The plugin can run simultaneously with the Mega Man Damage Shuffler.
* For Battletoads games, you can choose the level where you start and enable other bonuses, like choosing your start level (to shuffle many levels all together), skip Clinger-Winger, and more.

## Chaos Damage Shuffler: Setup
* First, [click here to download the latest version](https://github.com/Phiggle/bizhawk-shuffler-2/archive/refs/heads/main.zip) of the main branch of this repo. This includes the Chaos Shuffler plugin and hash database.
* Next, follow the **[Setup Instructions](https://github.com/authorblues/bizhawk-shuffler-2/wiki/Setup-Instructions)** by authorblues, linked right there and/or at the [main repo](https://github.com/authorblues/bizhawk-shuffler-2).
* Finally, when you are setting up a run, **enable the Chaos Shuffler plugin** and follow the displayed instructions, including what to do with the shuffle timers.
* Be aware that, if you are including randomizers or romhacks, you will need to add hashes to the .dat file that correspond to the game that was modified. Just copy and paste a line from the corresponding game (e.g., Link to the Past for ALTTPR), replace the original hash with yours, and save. BizHawk or the shuffler should print the SHA-1 hash if it is missing from the .dat file.
* **TO THOSE PLAYING N64 GAMES: REMEMBER TO ENABLE THE EXPANSION PAK!**
* **TO THOSE PLAYING SEGA CD AND SEGA SATURN GAMES: YOU NEED BIZHAWK 2.10, MINIMUM!** I'll eventually require 2.10 and up.

## Chaos Damage Shuffler: Thanks
* **This plugin is a mod of the excellent work by authorblues and kalimag on the Mega Man damage shuffler.** I'd have no idea what I was doing (well, moreso) without their work.
* A massive **thank you to Rogue_Millipede, Shadow Hog, kalimag, expeditedDelivery, Smight, endrift, ZoSym, and Extreme0** is also in order for their work on this plugin, adding shuffling for many new games and vastly improving it!
* Finally, thank you to Diabetus, Smight, and ConstantineDTW for extensive playthroughs that tracked down bugs.
* Did I mention I am a novice and do this on a pretty sporadic basis? I am very grateful for reports of any bugs or general mistakes/bad ideas!