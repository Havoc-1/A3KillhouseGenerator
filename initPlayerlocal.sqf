//Executed locally when player joins mission (includes both mission start and JIP). 				  //
params ["_player", "_didJIP"];	

// TSP Killhouse Generation
private _createKillhouseActions = {
    params ["_object", "_start", "_end", "_area", "_khNumber"];
    
    // Main action
    private _action = [
        format["KH%1_Generate", _khNumber],           
        format["Generate Killhouse %1", _khNumber],    
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
        {},                      
        {true},                  
        {},                      
        []                       
    ] call ace_interact_menu_fnc_createAction;
    
    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    
    // Map types
    private _maps = [
        ["Altis", enemy_altis, civ_altis, furniture_altis],
        ["Tanoa", enemy_tanoa, civ_tanoa, furniture_tanoa],
        ["Livonia", enemy_livonia, civ_livonia, furniture_livonia]
    ];
    
    {
        _x params ["_mapName", "_enemyTypes", "_civTypes", "_furnitureTypes"];
        
        // Map category
        private _mapAction = [
            format["KH%1_%2", _khNumber, _mapName],
            _mapName,
            "",
            {},
            {true},
            {},
            []
        ] call ace_interact_menu_fnc_createAction;
        
        [_object, 0, ["ACE_MainActions", format["KH%1_Generate", _khNumber]], _mapAction] call ace_interact_menu_fnc_addActionToObject;
        
        // Live and Target modes
        private _modes = [
            ["Live", 0.7, 0.05, 0, east],
            ["Targets", 0, 0, 0.25, resistance]
        ];
        
        {
            _x params ["_modeName", "_enemyChance", "_civilChance", "_targetChance", "_side"];
            
            private _modeAction = [
                format["KH%1_%2_%3", _khNumber, _mapName, _modeName],
                _modeName,
                "",
                {},
                {true},
                {},
                []
            ] call ace_interact_menu_fnc_createAction;
            
            [_object, 0, ["ACE_MainActions", format["KH%1_Generate", _khNumber], format["KH%1_%2", _khNumber, _mapName]], _modeAction] call ace_interact_menu_fnc_addActionToObject;
            
            // Lock chances
            private _lockChances = [
                ["All Doors Locked", 1],
                ["80% Doors Locked", 0.8],
                ["50% Doors Locked", 0.5],
                ["10% Doors Locked", 0.1],
                ["No Doors Locked", 0]
            ];
            
            {
                _x params ["_lockName", "_lockChance"];
                
                private _action = [
                    format["KH%1_%2_%3_%4", _khNumber, _mapName, _modeName, _forEachIndex],
                    _lockName,
                    "",
                    {
                        params ["_target", "_player", "_params"];
                        _params params ["_start", "_end", "_area", "_enemyTypes", "_civTypes", "_furnitureTypes", "_enemyChance", "_civilChance", "_targetChance", "_lockChance", "_side"];
                        
                        [
                            [
                                _start, _end, _area, 6, 18, 5, 0,
                                ["Bro_MSW_2m"], "Bro_MSW_2m_conc", 2,
                                ["Bro_MSW_2m_d", "Bro_MSW_2m_d", "Bro_MSW_2m_de"], "Bro_MSW_2m_d_conc", 0.2, 0.95, _lockChance,
                                10, 20, 0.05, _enemyChance, _side, _enemyTypes, _civilChance, _civTypes, _targetChance, ["Target_F"], 0.5, _furnitureTypes
                            ],
                            tsp_fnc_killhouse
                        ] remoteExec ["spawn", 2];
                    },
                    {!(_this select 2 select 0 getVariable ['generating', false])},
                    {},
                    [_start, _end, _area, _enemyTypes, _civTypes, _furnitureTypes, _enemyChance, _civilChance, _targetChance, _lockChance, _side]
                ] call ace_interact_menu_fnc_createAction;
                
                [_object, 0, ["ACE_MainActions", format["KH%1_Generate", _khNumber], format["KH%1_%2", _khNumber, _mapName], format["KH%1_%2_%3", _khNumber, _mapName, _modeName]], _action] call ace_interact_menu_fnc_addActionToObject;
            } forEach _lockChances;
        } forEach _modes;
    } forEach _maps;
};

// Create ACE actions for Killhouse 1 light switch
private _mainAction1 = [
    "LightControl_1",
    "Killhouse 1 Lights",
    "a3\3den\data\displays\display3den\toolbar\flashlight_off_ca.paa",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;

// Turn On action for Killhouse 1
private _turnOnAction1 = [
    "TurnOn_1","Turn On Lights","a3\3den\data\controls\ctrlcheckbox\baseline_texturechecked_ca.paa",
    {
        params ["_target", "_player", "_params"];
        _light = _params select 0;
        {
            [_x, false] remoteExec ["hideObjectGlobal", 2]
        } forEach lights_kh1;
        playSound "FD_Target_PopDown_Large_F";
    },
    {true},
    {},
    [lights_kh1]
] call ace_interact_menu_fnc_createAction;

// Turn Off action for Killhouse 1
private _turnOffAction1 = [
    "TurnOff_1","Turn Off Lights","a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_cancel_ca.paa",
    {
        params ["_target", "_player", "_params"];
        _light = _params select 0;
        {
            [_x, true] remoteExec ["hideObjectGlobal", 2]
        } forEach lights_kh1;
        playSound "FD_Target_PopDown_Large_F";
    },
    {true},
    {},
    [lights_kh1]
] call ace_interact_menu_fnc_createAction;



// Killhouse 2 light switch
private _mainAction2 = [
    "LightControl_2","Killhouse 2 Lights","a3\3den\data\displays\display3den\toolbar\flashlight_off_ca.paa",
    {},
    {true}
] call ace_interact_menu_fnc_createAction;


// Turn On action for Killhouse 2
private _turnOnAction2 = [
    "TurnOn_2","Turn On Lights","a3\3den\data\controls\ctrlcheckbox\baseline_texturechecked_ca.paa",
    {
        params ["_target", "_player", "_params"];
        _light = _params select 0;
        {
            [_x, false] remoteExec ["hideObjectGlobal", 2]
        } forEach lights_kh2;
        playSound "FD_Target_PopDown_Large_F";
    },
    {true},
    {},
    [lights_kh2]
] call ace_interact_menu_fnc_createAction;

// Turn Off action for Killhouse 2
private _turnOffAction2 = [
    "TurnOff_2","Turn Off Lights","a3\ui_f\data\igui\cfg\actions\obsolete\ui_action_cancel_ca.paa",
    {
        params ["_target", "_player", "_params"];
        _light = _params select 0;
        {
            [_x, true] remoteExec ["hideObjectGlobal", 2]
        } forEach lights_kh2;
        playSound "FD_Target_PopDown_Large_F";
    },
    {true},
    {},
    [lights_kh2]
] call ace_interact_menu_fnc_createAction;

[lightSwitch1, 0, ["ACE_MainActions"], _mainAction1] call ace_interact_menu_fnc_addActionToObject;
[lightSwitch1, 0, ["ACE_MainActions", "LightControl_1"], _turnOnAction1] call ace_interact_menu_fnc_addActionToObject;
[lightSwitch1, 0, ["ACE_MainActions", "LightControl_1"], _turnOffAction1] call ace_interact_menu_fnc_addActionToObject;
[lightSwitch2, 0, ["ACE_MainActions"], _mainAction2] call ace_interact_menu_fnc_addActionToObject;
[lightSwitch2, 0, ["ACE_MainActions", "LightControl_2"], _turnOnAction2] call ace_interact_menu_fnc_addActionToObject;
[lightSwitch2, 0, ["ACE_MainActions", "LightControl_2"], _turnOffAction2] call ace_interact_menu_fnc_addActionToObject;

// Add actions to each generator
[kh1_generator, kh1_start, kh1_end, kh1_area, 1] call _createKillhouseActions;
[kh2_generator, kh2_start, kh2_end, kh2_area, 2] call _createKillhouseActions;
