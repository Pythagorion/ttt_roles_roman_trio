-- replicated convars have to be created on both client and server
CreateConVar("ttt_optio_use_pumpgun_instead", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt_optio_traitor_time_of_respawn", 10, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_optio_convars", function(tbl)
    tbl[ROLE_OPTIO] = tbl[ROLE_OPTIO] or {}

    table.insert(tbl[ROLE_OPTIO], {cvar = "ttt_optio_use_pumpgun_instead", checkbox = true, desc = "ttt_optio_use_pumpgun_instead (def. 1)"})
    table.insert(tbl[ROLE_OPTIO], {cvar = "ttt_optio_traitor_time_of_respawn", slider = true, min = 0, max = 100, decimal = 0, desc = "ttt_optio_traitor_time_of_respawn (def. 10)"})
end)