
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

## Editor mode

run `love .` on main directory to launch editor mode.
You can play around with it but some features may be broken.

## Release mode

run `love . release` on main directory to launch the game.
Only one scene can be played at the moment, you can change the default scene in `main.lua`.

```lua
SM:init(Game)
-- TODO default scene
Game:load_scene(EM, "<TYPE SCENE NAME>")
```

## Git lfs

binary files are managed by git lfs.


# Shipping 🚢

- **Windows**: Dive into the `scripts\` folder and run the `ship_windows.bat` (double-click is fine) 

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
