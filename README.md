# HuntTheWampus

<h2>How to Play</h2>

All you need is the HuntTheWampus.exe and HuntTheWampus.pck found in Executables folder. Then open and .exe and play.

<h2>General Requests</h2>

Please keep the files organized based on folder name. I.e. Scenes go in the Sences folder, assests go in the asset folder, create subfolders as needed to keep everything organized. Color Scheme and vibe will be decided later, focuse on adding functionality over making it look good right now.

Theme: Ancient Greece Legends, Heracules Hunting the Neniam Wampus or Sphinx so there is riddles

Rooms: Use tiles set. 45 tiles horizontal by 26 tiles vertial


<h1>Weekly Roles:</h1>

Grady: Add spikes. Make the wampus, (priorize making the pit wampus and the store wampus)

Atalay: Update the rooms with new tileset

Owen: Finish and test the procedual generated map


<h1>Game Functionality</h1>

Global.gd is called on start and can be call from anywhere. Call Global.rng to get random numbers based on a set seed.

<h2>Coinage</h2>

Collect coins when going between rooms, have parcour between rooms to obtain coin or a bypass if they don't need them. This is a good place to mess around with procedural generation. Coinage is used when responding to a question or to pay at the store. Total ending coinage is added to the score.

<h2>Room Attributes:</h2>

Number (1-30)
Adj. Rooms (1-3)
Pit (only if 28 other rooms don’t have it)
Bats (only if 28 other rooms don't have it and if this room doesn’t have a pit)
Wumpus (only if 29 other rooms don’t have it)

<h2>Monsters and Character</h2>
Bat:
When character enters room they get frozen, bat flies over they get moved to another room. Character appears in valid room chosen at random. Bat is removed from previous room and moved to another room.


Wampus:
Red lion thing. If you have a sword on you, you will hit it. Other wise, it will kill you.


Bottomless Pit:
Character fall and reaches the bottom,  wampus with a beard asks riddles. Need two correct answers to be let out. Sends you back to spawn. Each answer costs 1 coin

Store:
Can buy a sword, a hint towards the Wumpus' location, invulnerability to bats and pits for 10 seconds, or can gamble for more coins


Store:
Run by the store wampus. On first find they store keeper wampus will ask you 3 questions and if get two correct you will get 2 free arrows. Otherwise you have to spend your hard earned coinage


