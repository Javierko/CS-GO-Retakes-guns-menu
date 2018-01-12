

#define PLUGIN_AUTHOR "Javierko"
#define PLUGIN_VERSION "1.1"
#include <sourcemod>
#include <sdktools>
#include <cstrike>
#define usp "weapon_usp_silencer"
#define ak "weapon_ak47"
#define glock "weapon_glock"
#define m4a1 "weapon_m4a1"
new useable;
new arr[MAXPLAYERS + 1][2];
new Handle:h_timer = INVALID_HANDLE;
 
 
public Plugin myinfo =
{
    name = "Primary guns menu",
    author = PLUGIN_AUTHOR,
    description = "",
    version = PLUGIN_VERSION,
    url = "github.com/Javierko"
};
 
public OnPluginStart()
{
    RegConsoleCmd("sm_guns", CallBack);
    RegConsoleCmd("sm_zbrane", CallBack);
    HookEvent("round_start", Event_RoundStart,EventHookMode_Pre);
    HookEvent("round_start", EventCallBack);
    
    LoadTranslations("primarygunsmenu.phrases");
}
 
public OnMapStart()
{
    for(new i=1;i<=MaxClients;i++)
    {
        for(new k=0;k<2;k++)
        {
            arr[i][k] = -1;
        }
    }
}
 
public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    for(new q=1;q<=MaxClients;q++)
    {
        if(IsClientInGame(q)==true)
        {
            int team = GetClientTeam(q);
            if(team != 1) // if the player isn't a spectator
            {
                int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(q, a)) != -1)
                    {
                        RemovePlayerItem(q, weapon);
                    }
                }
                GivePlayerItem(q, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(q, "weapon_glock");
                   
                    if(arr[q][0]==-1)
                    {
                        GivePlayerItem(q, "weapon_ak47");
                    }
                    if(arr[q][0]==0)
                    {
                        GivePlayerItem(q, "weapon_ak47");
                    }
                    if(arr[q][0]==1)
                    {
                        GivePlayerItem(q, "weapon_galilar");
                    }
                    if(arr[q][0]==2)
                    {
                        GivePlayerItem(q, "weapon_ssg08");
                    }
                    if(arr[q][0]==3)
                    {
                        GivePlayerItem(q, "weapon_sg556");
                    }
                    if(arr[q][0]==4)
                    {
                        GivePlayerItem(q, "weapon_awp");
                    }
                    if(arr[q][0]==5)
                    {
                        GivePlayerItem(q, "weapon_g3sg1");
                    }
                    if(arr[q][0]==6)
                    {
                        GivePlayerItem(q, "weapon_famas");
                    }
                    if(arr[q][0]==7)
                    {
                        GivePlayerItem(q, "weapon_m4a1");
                    }
                    if(arr[q][0]==8)
                    {
                        GivePlayerItem(q, "weapon_m4a1_silencer");
                    }
                    if(arr[q][0]==9)
                    {
                        GivePlayerItem(q, "weapon_aug");
                    }
                    if(arr[q][0]==10)
                    {
                        GivePlayerItem(q, "weapon_scar20");
                    }
                    if(arr[q][0]==11)
                    {
                        GivePlayerItem(q, "weapon_mac10");
                    }
                    if(arr[q][0]==12)
                    {
                        GivePlayerItem(q, "weapon_mp7");
                    }
                    if(arr[q][0]==13)
                    {
                        GivePlayerItem(q, "weapon_ump45");
                    }
                    if(arr[q][0]==14)
                    {
                        GivePlayerItem(q, "weapon_p90");
                    }
                    if(arr[q][0]==15)
                    {
                        GivePlayerItem(q, "weapon_bizon");
                    }
                    if(arr[q][0]==16)
                    {
                        GivePlayerItem(q, "weapon_mp9");
                    }
                    if(arr[q][0]==17)
                    {
                        GivePlayerItem(q, "weapon_nova");
                    }
                    if(arr[q][0]==18)
                    {
                        GivePlayerItem(q, "weapon_xm1014");
                    }
                    if(arr[q][0]==19)
                    {
                        GivePlayerItem(q, "weapon_sawedoff");
                    }
                    if(arr[q][0]==20)
                    {
                        GivePlayerItem(q, "weapon_m249");
                    }
                    if(arr[q][0]==21)
                    {
                        GivePlayerItem(q, "weapon_negev");
                    }
                    if(arr[q][0]==22)
                    {
                        GivePlayerItem(q, "weapon_mag7");
                    }              
                }
               
                if(team==3)
                {
                    GivePlayerItem(q, "weapon_usp_silencer");
                   
                    if(arr[q][0]==-1)
                    {
                        GivePlayerItem(q, "weapon_m4a1_silencer");
                    }
                    if(arr[q][0]==0)
                    {
                        GivePlayerItem(q, "weapon_ak47");
                    }
                    if(arr[q][0]==1)
                    {
                        GivePlayerItem(q, "weapon_galilar");
                    }
                    if(arr[q][0]==2)
                    {
                        GivePlayerItem(q, "weapon_ssg08");
                    }
                    if(arr[q][0]==3)
                    {
                        GivePlayerItem(q, "weapon_sg556");
                    }
                    if(arr[q][0]==4)
                    {
                        GivePlayerItem(q, "weapon_awp");
                    }
                    if(arr[q][0]==5)
                    {
                        GivePlayerItem(q, "weapon_g3sg1");
                    }
                    if(arr[q][0]==6)
                    {
                        GivePlayerItem(q, "weapon_famas");
                    }
                    if(arr[q][0]==7)
                    {
                        GivePlayerItem(q, "weapon_m4a1");
                    }
                    if(arr[q][0]==8)
                    {
                        GivePlayerItem(q, "weapon_m4a1_silencer");
                    }
                    if(arr[q][0]==9)
                    {
                        GivePlayerItem(q, "weapon_aug");
                    }
                    if(arr[q][0]==10)
                    {
                        GivePlayerItem(q, "weapon_scar20");
                    }
                    if(arr[q][0]==11)
                    {
                        GivePlayerItem(q, "weapon_mac10");
                    }
                    if(arr[q][0]==12)
                    {
                        GivePlayerItem(q, "weapon_mp7");
                    }
                    if(arr[q][0]==13)
                    {
                        GivePlayerItem(q, "weapon_ump45");
                    }
                    if(arr[q][0]==14)
                    {
                        GivePlayerItem(q, "weapon_p90");
                    }
                    if(arr[q][0]==15)
                    {
                        GivePlayerItem(q, "weapon_bizon");
                    }
                    if(arr[q][0]==16)
                    {
                        GivePlayerItem(q, "weapon_mp9");
                    }
                    if(arr[q][0]==17)
                    {
                        GivePlayerItem(q, "weapon_nova");
                    }
                    if(arr[q][0]==18)
                    {
                        GivePlayerItem(q, "weapon_xm1014");
                    }
                    if(arr[q][0]==19)
                    {
                        GivePlayerItem(q, "weapon_sawedoff");
                    }
                    if(arr[q][0]==20)
                    {
                        GivePlayerItem(q, "weapon_m249");
                    }
                    if(arr[q][0]==21)
                    {
                        GivePlayerItem(q, "weapon_negev");
                    }
                    if(arr[q][0]==22)
                    {
                        GivePlayerItem(q, "weapon_mag7");
                    }      
                   
                }
            }
        }
    }
    useable = 1;
    h_timer = CreateTimer(15.0, TimerCallBack);
}
public Action TimerCallBack(Handle:timer)
{
    useable = 0;
}
 
public Action CallBack(client,args)
{
    if(useable==0)
    {
        ReplyToCommand(client, "%T", "CantUse15secs");
    }
    if(useable==1)
    {
        arr[client][1] = -1;
        new Handle:menu = CreateMenu(menu1, MenuAction_Select | MenuAction_End | MenuAction_DisplayItem);
        SetMenuTitle(menu, "%T", "MainMenuChooseOption");
        AddMenuItem(menu, "%T", "ChooseGun");
        AddMenuItem(menu, "%T", "ChooseGunEveryRound");
        DisplayMenu(menu, client, MENU_TIME_FOREVER);
    }
}
 
public menu1(Handle:menu, MenuAction:action, param1, param2)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            //param1 is client, param2 is item
 
            new String:item[64];
            GetMenuItem(menu, param2, item, sizeof(item));
 
            if (StrEqual(item, "ChooseGun"))
            {
                new Handle:menu2 = CreateMenu(guns, MenuAction_Select | MenuAction_Cancel | MenuAction_End | MenuAction_DisplayItem);
                SetMenuTitle(menu2, "%T", "ChooseGun");
                AddMenuItem(menu2, "AK-47", "AK-47");
                AddMenuItem(menu2, "Galil AR", "Galil AR");
                AddMenuItem(menu2, "SSG 08", "SSG 08");
                AddMenuItem(menu2, "SG 556", "SG 556");
                AddMenuItem(menu2, "AWP", "AWP");
                AddMenuItem(menu2, "G3SG1", "G3SG1");
                AddMenuItem(menu2, "FAMAS", "FAMAS");
                AddMenuItem(menu2, "M4A4", "M4A4");
                AddMenuItem(menu2, "M4A1-S", "M4A1-S");
                AddMenuItem(menu2, "AUG", "AUG");
                AddMenuItem(menu2, "SCAR-20", "SCAR-20");
                AddMenuItem(menu2, "MAC-10", "MAC-10");
                AddMenuItem(menu2, "MP7", "MP7");
                AddMenuItem(menu2, "UMP-45", "UMP-45");
                AddMenuItem(menu2, "P90", "P90");
                AddMenuItem(menu2, "PP-Bizon", "PP-Bizon");
                AddMenuItem(menu2, "MP9", "MP9");
                AddMenuItem(menu2, "Nova", "Nova");
                AddMenuItem(menu2, "XM1014", "XM1014");
                AddMenuItem(menu2, "Sawed-Off", "Sawed-Off");
                AddMenuItem(menu2, "M249", "M249");
                AddMenuItem(menu2, "Negev", "Negev");
                AddMenuItem(menu2, "MAG-7", "MAG-7");
                DisplayMenu(menu2, param1, MENU_TIME_FOREVER);
            }
            else if (StrEqual(item, "ChooseGunEveryRound"))
            {
                arr[param1][1] =1;
            }
        }
 
        case MenuAction_End:
        {
            //param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
            CloseHandle(menu);
 
        }
 
        case MenuAction_DisplayItem:
        {
            //param1 is client, param2 is item
 
            new String:item[64];
            GetMenuItem(menu, param2, item, sizeof(item));
 
            if (StrEqual(item, "ChooseGun"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "ChooseGun", param1);   //Choose gun this round
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "ChooseGunEveryRound"))  //Choose gun every round
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "ChooseGunEveryRound", param1);    //Choose gun every round
                return RedrawMenuItem(translation);
            }
        }
 
    }
    return 0;
}
public guns(Handle:menu2, MenuAction:action, param1, param2)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            //param1 is client, param2 is item
 
            new String:item[64];
            GetMenuItem(menu2, param2, item, sizeof(item));
            int team = GetClientTeam(param1);
 
            if (StrEqual(item, "AK-47"))
            {
                arr[param1][0] = 0;
                if(useable==1)
                {
				int a;
				for(a = 0; a < 4; a++) // remove all weapons
				{
                int weapon;
                while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                {
                  RemovePlayerItem(param1, weapon);
                }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                  GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                  GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_ak47");
                }  
            }
            else if (StrEqual(item, "Galil AR"))
            {
                arr[param1][0] = 1;
                if(useable==1)
                {
				int a;
				for(a = 0; a < 4; a++) // remove all weapons
				{
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_galilar");
                }
            }
            else if (StrEqual(item, "SSG 08"))
            {
                arr[param1][0] = 2;
                if(useable==1)
                {
				int a;
				for(a = 0; a < 4; a++) // remove all weapons
				{
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_ssg08");
                }
            }
            else if (StrEqual(item, "SG 556"))
            {
                arr[param1][0] = 3;
                if(useable==1)
                {
				int a;
				for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_sg556");
                }
            }
            else if (StrEqual(item, "AWP"))
            {
                arr[param1][0] = 4;
                if(useable==1)
                {
				int a;
				for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_awp");
                }
            }
            else if (StrEqual(item, "G3SG1"))
            {
                arr[param1][0] = 5;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_g3sg1");
                }
            }
            else if (StrEqual(item, "FAMAS"))
            {
                arr[param1][0] = 6;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_famas");
                }
            }
            else if (StrEqual(item, "M4A4"))
            {
                arr[param1][0] = 7;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_m4a1");
                }
            }
            else if (StrEqual(item, "M4A1-S"))
            {
                arr[param1][0] = 8;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_m4a1_silencer");
                }
            }
            else if (StrEqual(item, "AUG"))
            {
                arr[param1][0] = 9;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_aug");
                }
            }
            else if (StrEqual(item, "SCAR-20"))
            {
                arr[param1][0] = 10;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_scar20");
                }
            }
            else if (StrEqual(item, "MAC-10"))
            {
                arr[param1][0] = 11;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_mac10");
                }
            }
            else if (StrEqual(item, "MP7"))
            {
                arr[param1][0] = 12;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_mp7");
                }
            }
            else if (StrEqual(item, "UMP-45"))
            {
                arr[param1][0] = 13;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_ump45");
                }
            }
            else if (StrEqual(item, "P90"))
            {
                arr[param1][0] = 14;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_p90");
                }
            }
            else if (StrEqual(item, "PP-Bizon"))
            {
                arr[param1][0] = 15;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_bizon");
                }
            }
            else if (StrEqual(item, "MP9"))
            {
                arr[param1][0] = 16;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_mp9");
                }
            }
            else if (StrEqual(item, "Nova"))
            {
                arr[param1][0] = 17;
                if(useable==1)
                {
                 int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_nova");
                }
            }
            else if (StrEqual(item, "XM1014"))
            {
                arr[param1][0] = 18;
                if(useable==1)
                {
				int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_xm1014");
                }
            }
            else if (StrEqual(item, "Sawed-Off"))
            {
                arr[param1][0] = 19;
                if(useable==1)
                {
                int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_sawedoff");
                }
            }
            else if (StrEqual(item, "M249"))
            {
                arr[param1][0] = 20;if(useable==1)
                {
                 int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_m249");
                }
            }
            else if (StrEqual(item, "Negev"))
            {  
                arr[param1][0] = 21;
                if(useable==1)
                {
                 int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_negev");
                }
            }
            else if (StrEqual(item, "MAG-7"))
            {
                arr[param1][0] = 22;
                if(useable==1)
                {
                 int a;
                for(a = 0; a < 4; a++) // remove all weapons
                {
                    int weapon;
                    while((weapon = GetPlayerWeaponSlot(param1, a)) != -1)
                    {
                        RemovePlayerItem(param1, weapon);
                    }
                }
                GivePlayerItem(param1, "weapon_knife");
                if(team==2)
                {
                    GivePlayerItem(param1, "weapon_glock");
                }
                if(team==3)
                {
                    GivePlayerItem(param1, "weapon_usp_silencer")
                }
                GivePlayerItem(param1, "weapon_mag7");
                }
            }
        }
        case MenuAction_Cancel:
        {
            //param1 is client, param2 is cancel reason (see MenuCancel types)
            if (param2 == MenuCancel_ExitBack)
            {
                //Code to return to parent menu
 
            }
 
        }
 
        case MenuAction_End:
        {
            //param1 is MenuEnd reason, if canceled param2 is MenuCancel reason
            CloseHandle(menu2);
 
        }
 
        case MenuAction_DisplayItem:
        {
            //param1 is client, param2 is item
 
            new String:item[64];
            GetMenuItem(menu2, param2, item, sizeof(item));
 
            if (StrEqual(item, "AK-47"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "AK-47", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "Galil AR"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "Galil AR", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "SSG 08"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "SSG 08", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "SG 556"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "SG 556", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "AWP"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "AWP", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "G3SG1"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "G3SG1", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "FAMAS"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "FAMAS", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "M4A4"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "M4A4", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "M4A1-S"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "M4A1-S", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "AUG"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "AUG", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "SCAR-20"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "SCAR-20", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "MAC-10"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "MAC-10", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "MP7"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "MP7", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "UMP-45"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "UMP-45", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "P90"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "P90", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "PP-Bizon"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "PP-Bizon", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "MP9"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "MP9", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "Nova"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "Nova", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "XM1014"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "XM1014", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "Sawed-Off"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "Sawed-Off", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "M249"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "M249", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "Negev"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "Negev", param1);
                return RedrawMenuItem(translation);
            }
            else if (StrEqual(item, "MAG-7"))
            {
                new String:translation[128];
                Format(translation, sizeof(translation), "%T", "MAG-7", param1);
                return RedrawMenuItem(translation);
            }
        }
 
    }
    return 0;
}
public void EventCallBack(Event event, const char[] name, bool dontBroadcast)
{
    for(new h=1;h<=MaxClients;h++)
    {
        if(IsClientInGame(h)==true&&GetClientTeam(h)!=1&&arr[h][1]==-1)
        {
            new Handle:menu = CreateMenu(menu1, MenuAction_Select | MenuAction_End | MenuAction_DisplayItem);
            SetMenuTitle(menu, "%T", "MainMenuChooseOption");
            AddMenuItem(menu, "%T", "ChooseGun");
            AddMenuItem(menu, "%T", "ChooseGunEveryRound");
            DisplayMenu(menu, 15.0, h_timer);
        }
    }
}

