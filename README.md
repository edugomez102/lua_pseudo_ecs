
# Last changes in `editor` branch !!

# ECS like lua game engine

Simplification of an ECS engine using lua tables and the love2d library.

# Achieved

- Entity and System Managers
- Delete dead entities
- Simple WASD input
- Simple AI move patrols
- Simple 2D collisions
- Simple color rectangle render 
- Level loader with a list of entities

# Setup

love2d library is needed.

run `love .` on main directory.

# Shipping 🚢 (TODO: Move to conlfuence)
- **Windows**  
  - From Windows: dive into the `scripts\windows` folder and run the `ship_windows.bat` (double-click is fine)
- **Linux**
  - From Windows:
  - From Linux (Arch):
- **Switch**
  - From Windows: 
  - From Linux (Arch)
    - (Just once) Dive into the `scripts\linux-arch\switch` folder, and run `sudo setup_switch.sh` in order to install the neccessary software
    - Every time you want to build your game, run `ship_switch.sh` on the same folder

# Folder Structure

## engine  

- cmps: Engine Components
- sys: Engine Systems
- man: Engine Managers

## game

Depending on the game mechanics the following folders may change to achive the desired game.

- beh: Game behaviours functions of ai and collision for example
- resources: Game levels, animations, sprites...
- assets: Game assets

- cmps: Game Components
- sys: Game Systems
- man: Game Managers

## modules 

- file with personal lua funcs

# TODO

- [ ] Animator system
