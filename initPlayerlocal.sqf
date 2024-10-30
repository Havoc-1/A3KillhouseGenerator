//TSP Killhouse MakeCaptive
[
    {
        !isNull findDisplay 46;
    },
    {
        params ["_player"];
        [
            {
                _args params ["_player"];
                _player setCaptive (_player inArea zone_captive);
                //diag_log format ["%1 set as captive.", _player];
            },
            1,
            [_player]
        ] call CBA_fnc_addPerFrameHandler;
    },
    [_player]
] call CBA_fnc_waitUntilAndExecute;
