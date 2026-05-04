<img width="470" height="283" alt="image" src="https://github.com/user-attachments/assets/14e3da0a-44f5-4551-a7b5-4ef965a522b5" /><img width="593" height="229" alt="image" src="https://github.com/user-attachments/assets/96d85086-ce21-437e-b1a2-8a721fa7a4ff" /># EE2026-AY25-26-sem-2-project

```
_____/\\\\\\\\\\\______________/\\\\\___________/\\\\\\\_______________/\\\____        
 ___/\\\/////////\\\________/\\\\////__________/\\\/////\\\___________/\\\\\____       
  __\//\\\______\///______/\\\///______________/\\\____\//\\\________/\\\/\\\____      
   ___\////\\\___________/\\\\\\\\\\\__________\/\\\_____\/\\\______/\\\/\/\\\____     
    ______\////\\\_______/\\\\///////\\\________\/\\\_____\/\\\____/\\\/__\/\\\____    
     _________\////\\\___\/\\\______\//\\\_______\/\\\_____\/\\\__/\\\\\\\\\\\\\\\\_   
      __/\\\______\//\\\__\//\\\______/\\\________\//\\\____/\\\__\///////////\\\//__  
       _\///\\\\\\\\\\\/____\///\\\\\\\\\/____/\\\__\///\\\\\\\/_____________\/\\\____ 
        ___\///////////________\/////////_____\///_____\///////_______________\///_____
```

# About us
Members:
1) Er Chen Wen: Game_1 Cut the wire, Integration process, mouse            
2) Dexter Peh:  Game_2 Simon says, Integration process
3) Hedley Koh: Game_3 Maze, Integration process, Countdown timer display with audio output
4) Tan Jun Yi: Game_4 Symbols, Master Integration process

# Description
## Project "bomb squad"

Players have to “diffuse the bomb” by solving 4 puzzle games within 3 minutes and with more than 0 health remaining. The game starts when any button is pressed in the start screen.
<img width="775" height="495" alt="image" src="https://github.com/user-attachments/assets/56351817-cfbf-48c6-ae84-56e9beb30710" />
<img width="603" height="420" alt="image" src="https://github.com/user-attachments/assets/9cc2d4a5-4b9d-4f7d-867b-286fb17ff3c1" />
<img width="593" height="229" alt="image" src="https://github.com/user-attachments/assets/c44ee8ed-7bd8-43cc-a51b-87d717f82983" />

When successful, DIFFUSED screen is shown. Otherwise, EXPLODED screen is shown. Press any button to reset upon DIFFUSED or EXPLODED.
<img width="467" height="313" alt="image" src="https://github.com/user-attachments/assets/464be4a1-5f16-4dcd-a046-96a80e6c4af8" />
<img width="470" height="283" alt="image" src="https://github.com/user-attachments/assets/3fa13181-be2d-4b09-832e-b0f20d82c925" />
<img width="617" height="591" alt="image" src="https://github.com/user-attachments/assets/ea86ab9d-1405-40e6-a28a-dbb6cd8bcae5" />


## Randomisation:
games can appear in any order, 24 possible sequences
Game 1 has 16,807 permutations
Game 2 has 8 permutations
Game 3 has 8 permutations
Game 4 has 192 permutations
Total possible game permutations: 4,956,585,984

## Game 1
Cut The Wire Game
<img width="439" height="288" alt="image" src="https://github.com/user-attachments/assets/b460b28d-6e1e-4676-8b9c-ee38c118c4ce" />

Game begins with 5 coloured wires on the JB port using pseudo-randomisation of 32 bits.
<img width="329" height="218" alt="image" src="https://github.com/user-attachments/assets/c1d1dc8c-9f31-4b61-81bb-16e640db153c" />

The player will cycle through the ordered wires highlighted in WHITE using ‘btnL and btnR’ or the mouse.

To select the wire, the player must press btnC or mouse’s left_click.
<img width="325" height="208" alt="image" src="https://github.com/user-attachments/assets/5df27bf7-f791-4191-85c8-2e14498a9117" />

When wires are cut wrongly, healthpoint will be taken via LED. The Player will not be able to select the same wire.

When cut correctly, if more wires are required to be cut, the game will continue. Otherwise, the round will end.

The game lasts for 3 rounds.
<img width="329" height="218" alt="image" src="https://github.com/user-attachments/assets/6d2e70f9-84b3-4980-9d95-9e436b6d6f31" />

## Game 2
Simon Says Game:

Player 1’s JA OLED Screen would have the instructions on sequence of colours to press
<img width="551" height="397" alt="image" src="https://github.com/user-attachments/assets/6a070fc8-c1d1-46c8-97f0-e2d9522e8a79" />

Player 2’s JB OLED Screen would have a manual and the player would have to press the coloured diamonds in sequence,using the pushbuttons and the instructions verbally said out by player 1
<img width="334" height="236" alt="image" src="https://github.com/user-attachments/assets/2e6d76c8-dd14-427d-9448-900ea4c0f30b" />

The screen flashes green when a player passes a round.

If player 2 pressed wrongly, the players’ health will be deducted via LED 

(Note: player has to wait for the sequence to complete before any button press made)

## Game 3
The Maze Game:

Player 1’s JA OLED screen would show an image of 1 of the 8 mazes
<img width="500" height="728" alt="image" src="https://github.com/user-attachments/assets/7da1d462-e046-4269-a6f2-907c65beaec1" />

Player 2’s JB OLED screen would have a red dot which the player have to move it via the pushbuttons and is instructed by player 1 
<img width="416" height="278" alt="image" src="https://github.com/user-attachments/assets/3766cd3c-33e2-4e18-89bd-66e228ef7a8a" />

If player 2 has successfully reached the endpoint, both players would move on to the next game

If player 2 bumps into a wall, the player’s health will be deducted via LED

## Game 4
Symbols Game: 
<img width="582" height="376" alt="image" src="https://github.com/user-attachments/assets/703f3093-dcb8-4d80-8318-1582c0121af2" />

JB oled (right) displays 4 symbols and respective mapping to buttons. 
<img width="458" height="315" alt="image" src="https://github.com/user-attachments/assets/e2f07d50-23b1-457e-8cb2-363402d2423d" />

Instructions are shown in the JA oled (left). 
<img width="500" height="309" alt="image" src="https://github.com/user-attachments/assets/8d830cb2-6032-4f08-bc47-1b742223fad6" />

There are 8 possible ways to press the buttons, 8 sets of symbols, 3 column positions for 192 variations, preventing memorisation.

Gameplay:

Player 2 (right side) describes the 4 symbols seen.

Player 1 (left side) describes the correct sequence.

Player 2 presses buttons in correct order.


# How to use

1) Download release v1.0, launch it in Vivado 2018.2
2) Connect pmod OLED to ports JA and JB, pmod audio jack to port JC (optional for audio), mouse to USB port (for game 1)
3) Upload bistream Basys 3 board (note, no need to re-generate bitstream)
4) Enjoy!
