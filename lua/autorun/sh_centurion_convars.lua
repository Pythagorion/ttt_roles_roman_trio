-- replicated convars have to be created on both client and server
CreateConVar("ttt_cent_use_pumpgun_instead", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})
CreateConVar("ttt_cent_gladiator_time_of_respawn", 10, {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_cent_convars", function(tbl)
    tbl[ROLE_CENTURION] = tbl[ROLE_CENTURION] or {}

    table.insert(tbl[ROLE_CENTURION], {cvar = "ttt_cent_use_pumpgun_instead", checkbox = true, desc = "ttt_cent_use_pumpgun_instead (def. 1)"})
    table.insert(tbl[ROLE_CENTURION], {cvar = "ttt_cent_gladiator_time_of_respawn", slider = true, min = 0, max = 100, decimal = 0, desc = "ttt_cent_gladiator_time_of_respawn (def. 10)"})
end)