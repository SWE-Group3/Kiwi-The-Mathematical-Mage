# Kiwi: The Mathematical Mage

## Contributers

* Kaden Gardiner
* Lily Grippo
* Roberto Mercado
* Riley Miller
* Allen Zammer

## Project Description

Kiwi: The Mathematical Mage is a edutainment game designed to help 4th grade students practice math
in a fun and engaging way. In this game, players are tasked with helping a magical kiwi bird named
Kiwi defend a clutch of three eggs from endless waves of predators. Players will solve math problems
to help Kiwi generate mana so that he can cast spells. Players can then use this mana to cast his
spells at incoming predators, applying status effects and damage to them. At the end of every wave,
players will gain berries, which can be used to upgrade Kiwi's spells. Once they are ready, they can
signal the next wave and continue playing until all the eggs have been consumed by predators.

## Prototype Details

This project serves a initial prototype for Kiwi: The Mathematical Mage. The prototype itself is
build on top of Godot, a free and open source game engine. This prototype consists of several menus
for the player to navigate and a main game scene for the player to play through.When the game is
opened, the player will be presented with a main menu. From there, the player can choose to start
the game, adjust the volume through the options menu, select what kind of math problems they want to
focus on (addition, subtraction, multiplication, and division), and quit the game.

Once the player enters the main game scene, the player is presented with a how-to-play guide.
Closing the guide will reveal the scene, where the player can select upgrades through the upgrade
menu and signal the next wave. Once the next wave is signaled, the player will start generating
mana, see a math problem they can solve for more mana, and select spells to cast at predators, who
will begin to spawn from caverns. The predators will be removed when defeated by a spell or when
they touch the eggs at the end of the track, where they inflict damage before disappearing (this was
done for balancing purposes). The player can see how much health all the eggs have along with their
mana in progress bars. Once the last predator is removed, the wave ends and the player will see the
option to upgrade spells and signal the next wave again. The game will repeat this process until the
player decides to exit to the main menu from the pause menu or when they lose all their eggs to
predators. If the player loses all their eggs to predators, the game will kick them back to the main
menu and show the number of waves they've completed alongside their high score.

## Project Files

The project is divided into many subfolders that groups scripts and scenes together based on their
function. Art and audio can be found in their respective folders as well. Some parts of the code
files may be a little rough around the edges, so comments are provided to try to explain what is
going on.

## Build Instructions

To build and run the prototype, clone this repository into a local folder and locate the included
project.godot file from the Godot Engine project manager. Once the project has been imported, select
the project and click the Run button. To avoid potential issues, it is recommended to run this
project on Godot Engines versions 4.5 and above on a desktop or laptop. When the game opens
successfully, the main menu will appear and the game can be played from there. Note that the game
can only be played with a keyboard and mouse. No other input devices are supported.

## Known Issues

The game will not accept simplified answers to math problems with fractions or mixed numbers. In
addition, the game will not accept answers whose numerators are greater than their denominators,
as it is expecting the answer to be entered as a mixed number. When in doubt, prefer entering mixed
numbers over proper fractions for such problems.

Spell cooldowns are not implemented within this prototype even though our Software Requirements
Specification specified them. Although this was done for balancing purposes, it can be imagined that
spell cooldowns will be implemented when the game undergoes some serious balancing changes.

## Acknowledgments

* Built using Godot Engine
* Main menu background image by ChatGPT
* Music by Lily Grippo
* Kiwi blast sound effect by nameless kiwi bird

## Website Link

https://swe-group3.github.io/KiwiTheMathematicalMageWebsite/

## License

Kiwi: The Mathematical Mage is released under the MIT License. See LICENSE for details.
