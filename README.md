# HuntTheWampus

Please keep the files organized based on folder name. I.e. Scenes go in the Sences folder, assests go in the asset folder, create subfolders as needed to keep everything organized. Color Scheme and vibe will be decided later, focuse on adding functionality over making it look good right now.

Theme: Anceint Greece Legends, Heracules Hunting the Neniam Wampus or Sphinx so there is riddles
Assets: I (Grady) am making assets. If there is any asset you reqire please ask

Rooms: Use tiles set. 45 tiles horizontal by 26 tiles vertial


<h1>Weekly Roles:</h1>

Grady: Make the wampus, (priorize making the pit wampus and the store wampus)

Atalay: Update the rooms with new tileset

Owen: Finish and test the procedual generated map


<h1>Game Functionality</h1>

Global.gd is called on start and can be call from anywhere. Call Global.rng to get random numbers based on a set seed.

<h2>Room Attributes:</h2>

Number (1-30)
Adj. Rooms (1-3)
Pit (only if 28 other rooms don’t have it)
Bats (only if 28 other rooms don't have it and if this room doesn’t have a pit)
Wumpus (only if 29 other rooms don’t have it)

<h2>Monsters and Character</h2>
Bat:
When character enters room they get frozen, bat flies over then fade to black. Character appears in valid room chosen at random.


Wampus:
Red lion thing.


Bottomless Pit:
Character fall and reaches the bottom,  wampus with a beard asks riddles. Need three answers to be let out


Store:
Run by the store wampus. On first find they store keeper wampus will ask you 3 questions and if get two correct you will get 2 free arrows. Otherwise you have to spend your hard earned coinage


