# SKCGameJam2025
### Concept
Turn based puzzle game with multiple levels. The player is an employee at a furniture store, tasked with destroying evil sofas possessed by an alien virus.
### Player
The player can use their move to either move or attack in a chosen direction. The player has 3 lives and 3 starting bullets. The goal is to shoot all infected sofas.
### Sofa
Can be either infected (enemy), or a regular piece of furniture. The regular pieces stay still and take no turns. The infected pieces each get a turn after the player makes their move. There are 3 types of enemies - melee, ranged, and explosive. The melee enemies prioritize moving towards the player, only attacking when adjacent to the player. The ranged enemies will either choose to shoot the player (if player is in line of sight) or move by a single tile to better align themselves with the player. The explosive enemies will wait until the player is close enough to damage with the explosion.
### Other furniture
Other types of furniture exist:
- Tables and lamps: stationary, no special characteristics
- Boxes: give ammo to player when destroyed

[Play on itch.io](https://byk27.itch.io/fauxtelja)
