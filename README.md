# Arma 3 Dynamic Killhouse Generator

A dynamic killhouse generation system for Arma 3 that creates randomized CQB killhouses with configurable parameters. Framework created by ASmallDinosaur, using [Modular Shoothouse Parts](https://steamcommunity.com/sharedfiles/filedetails/?id=2975882889&searchtext=modular+shoothouse) by Brominum and QOL features by Keystone and PaperboatHat

## Features

- **Dynamic Layout Generation**: Creates randomized room layouts 
- **Multiple Environment Types**: Supports different furniture and enemy types based on Arma 3 maps 
	- Altis
	- Tanoa
	- Livonia
- **Customizable Population**:
  - Enemy units with configurable placement probability
  - Civilian units for no-shoot scenarios

- **Training Modes**:
  - **Live Fire**: Populated with AI combatants
  - **Target Practice**: Static targets for fundementals

### ACE Handling
- Generate killhouse
  - Configurable door states (locked/unlocked percentages)
 
    
![KillGen](https://github.com/user-attachments/assets/9645574a-f70c-46a5-9f67-59933689fbc8)


- Light control system for each killhouse


  ![LightControl](https://github.com/user-attachments/assets/67adb8de-5790-4088-98a3-09e33320a252)


- Automatic healing
  - Upon completion / failure
  - Exit stage
  - Teleported back to generator if all players are unconcious
 

![HealTP](https://github.com/user-attachments/assets/1a9cd102-d50f-472f-826d-f31837b52138) 

  - Adjusted sound effects with additional sound sources
  

## Dependency

- ACE3 Mod
- CBA Mod
- [Breach Mod](https://steamcommunity.com/sharedfiles/filedetails/?id=3283645995)

## Installation Methods

1a. Download mission file / scripts from the repository (Latest releases)


**or**


1b. Subscribe to the composition at [Killhouse Generator](https://steamcommunity.com/sharedfiles/filedetails/?id=3362606241)


2. Copy the following files to your mission folder:
   - `init.sqf`
   - `initPlayerLocal.sqf`
   - `khGenerator.sqf`

  
3. Place the composition on a **flat area**. Make sure that when placing,
	- Toggle Vertical mode to Sea Level (The straight arrow)  
	- Toggle surface snapping to off (Arrows pointing outwards)


![HEIGHT](https://github.com/user-attachments/assets/288f7407-cfcf-4dc7-8859-d3ca80f745a3)


## Usage

### Generator Interface

The killhouse generator provides an ACE interaction menu with the following options:

1. Select Map (Furniture set and Enemy Type):
   - Altis
   - Tanoa
   - Livonia

2. Select Mode:
   - Live (AI opponents)
   - Targets (Static targets)

3. Configure Door States:
   - All Doors Locked
   - 80% Doors Locked
   - 50% Doors Locked
   - 10% Doors Locked
   - No Doors Locked

### Light Control

Each killhouse has a light switch (Breaker switch near the front door) that allows players to:
- Turn all lights on
- Turn all lights off

## Configuration

### Enemy Types
The enemy unit classnames are in the `khGenerator.sqf` file:
```sqf
enemy_altis = ["O_G_Soldier_AR_F", "O_G_medic_F", ...];
enemy_tanoa = ["I_C_Soldier_Bandit_7_F", "I_C_Soldier_Bandit_3_F", ...];
enemy_livonia = ["I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", ...];
```

### Civilian Types
Customize civilian units:
```sqf
civ_altis = ["C_man_polo_1_F", "C_man_polo_2_F", ...];
civ_tanoa = ["C_Man_casual_1_F_tanoan", "C_Man_casual_2_F_tanoan", ...];
civ_livonia = ["C_Man_1_enoch_F", "C_Man_2_enoch_F", ...];
```

### Furniture
Each environment has its own furniture set:
```sqf
furniture_altis = [...];
furniture_tanoa = [...];
furniture_livonia = [...];
```

Each furniture entry follows the format:
```sqf
[
    "Classname",     // Object classname
    maxCount,        // Maximum instances
    radius,          // Placement radius
    rotation,        // Base rotation
    offset,          // Position offset
    verticalOffset,  // Height offset
    wallMount,       // Can be placed on walls
    openSpace,       // Can be placed in open areas
    corner,          // Can be placed in corners
    cornerDir,       // Use corner direction
    randomRotation   // Random rotation range
]
```

## Technical Details

### Generation Process

1. Area Preparation
   - Checks for player presence
   - Cleans up previous killhouse
   - Plays construction effects

2. Layout Generation
   - Creates wall grid
   - Generates random room layouts
   - Creates connections between rooms
   - Validates pathfinding

3. Population
   - Places units/targets based on mode
   - Adds furniture and props
   - Configures door states

4. Completion
   - Monitors for completion conditions
   - Handles player healing
   - Cleans up and resets

### Performance Considerations

- Uses sleep timers during generation to prevent frame drops
- Efficient object cleanup
- Disabled AI Pathfinding to ensure AI does not walk through walls 

## Authors 
- [@ASmallDinosaur / @aarengibson](https://github.com/aarengibson)
- [@_keystone / @Havoc-1](https://github.com/Havoc-1)
- [@Paperboathat](https://github.com/Paperboathat)
- [@Reeveli](https://github.com/Reeveli) for his ACE healing function


## Acknowledgements
ACE3 Team - Framework


CBA Team - Settings framework
  
## License
✔️ Modify this mod.


✔️ Redistribute this mod in part or whole privately / within a unit.


✔️ Redistribute this mod in part or whole publicly with credits linking to this page.


❌ Port this mod in part or whole to games other than ArmA.


❌ Use this mod for commercial purposes.


This project is licensed under the Arma Public License Share Alike (APL-SA) - see the [Bohemia Interactive Community License page](https://www.bohemia.net/community/licenses/arma-public-license-share-alike) for details.
