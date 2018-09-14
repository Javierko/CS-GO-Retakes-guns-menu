#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Javierko"
#define PLUGIN_VERSION "1.0.0"

#include <sourcemod>
#include <sdktools>
#include <cstrike>

bool g_bUseable[MAXPLAYERS + 1];
bool g_bChoosed[MAXPLAYERS + 1];
char g_cChoosedGunP[MAXPLAYERS + 1][32];
//char g_cChoosedGunS[32];

char g_cWeapons[][] =
{
	"weapon_ak47", "weapon_aug", "weapon_bizon", "weapon_deagle", "weapon_elite", "weapon_famas", "weapon_fiveseven",
	"weapon_g3sg1", "weapon_galilar", "weapon_glock", "weapon_hkp2000", "weapon_m249", "weapon_m4a1",
	"weapon_mac10", "weapon_mag7", "weapon_mp7", "weapon_mp9", "weapon_p250", "weapon_p90",
	"weapon_scar20", "weapon_sg556", "weapon_ssg08", "weapon_tec9", "weapon_ump45", "weapon_xm1014"
};

char g_cWeaponsNames[][] =
{
	"AK-47", "AUG", "Bizon", "Deagle", "Dual Berretas", "Famas", "Five-Seven",
	"G3SG1", "Galil", "Glock-18", "P-2000", "M-249", "M4A4",
	"Mac-10", "MAG-7", "MP7", "MP9", "P250", "P90",
	"SCAR-20", "Scout", "SSG 08", "Tec-9", "UMP-45", "XM1014"
};

#pragma newdecls required

public Plugin myinfo = 
{
	name = "[CS:GO] Guns menu",
	author = PLUGIN_AUTHOR,
	description = "",
	version = PLUGIN_VERSION,
	url = "https://github.com/javierko"
};

public void OnPluginStart()
{
	//Commands
	RegConsoleCmd("sm_guns", Command_Guns);
	
	//Events
	HookEvent("round_start", Event_RoundStart);
	
	//Translations
	LoadTranslations("javguns.phrases");
}

public Action Command_Guns(int client, int args)
{
	if(IsValidClient(client, true))
	{
		if(g_bUseable[client])
		{
			GunsMenu(client);
		}
		else
		{
			PrintToChat(client, "%t", "OnceTime");
		}
	}
	else
	{
		PrintToChat(client, "%t", "Alive");
	}
	
	return Plugin_Handled;
}

/*
Primary menu
*/

public void GunsMenu(int client)
{
	if(IsValidClient(client, true))
	{
		if(g_bUseable[client])
		{
			Menu menu = new Menu(mGunsMenu);
			menu.SetTitle("Choose your option:");
			menu.AddItem("cur", "Choose current gun");
			menu.AddItem("stable", "Choose permanent gun");
			
			menu.Display(client, 25);
		}
		else
		{
			PrintToChat(client, "%t", "OnceTime");
		}
	}
	else
	{
		PrintToChat(client, "%t", "Alive");
	}
}

public int mGunsMenu(Menu menu, MenuAction action, int client, int index)
{
	if(action == MenuAction_Select)
	{
		if(IsValidClient(client, true))
		{
			if(g_bUseable[client])
			{
				char szItem[12];
				menu.GetItem(index, szItem, sizeof(szItem));
				if(StrEqual(szItem, "cur"))
				{			
					ChooseGun(client);
				}
				else if(StrEqual(szItem, "stable"))
				{
					ChooseStableGun(client);
				}
			}
			else
			{
				PrintToChat(client, "%t", "OnceTime");
			}
		}
		else
		{
			PrintToChat(client, "%t", "Alive");
		}
	}
}

/*
Second menu
*/

public void ChooseStableGun(int client)
{
	if(IsValidClient(client))
	{
		if(g_bUseable[client])
		{
			Menu menu = new Menu(mChooseStableGun);
			menu.SetTitle("Choose gun");
			for(int wep; wep < sizeof(g_cWeapons); wep++)
			{
				menu.AddItem(g_cWeapons[wep], g_cWeaponsNames[wep]);
			}
			menu.ExitBackButton = true;
			menu.Display(client, 25);
		}
		else
		{
			PrintToChat(client, "%t", "OnceTime");
		}
	}
	else
	{
		PrintToChat(client, "%t", "Alive");
	}
}

public int mChooseStableGun(Menu menu, MenuAction action, int client, int index)
{
	if(action == MenuAction_Select)
	{
		if(IsValidClient(client, true))
		{
			if(g_bUseable[client])
			{
				char szItem[12];
				menu.GetItem(index, szItem, sizeof(szItem));
				g_bUseable[client] = true;
				g_bChoosed[client] = true;
				Format(g_cChoosedGunP[client], sizeof(g_cChoosedGunP[]), szItem);
				GivePlayerItem(client, szItem);
			}
			else
			{
				PrintToChat(client, "%t", "OnceTime");
			}
		}
		else
		{
			PrintToChat(client, "%t", "Alive");
		}
	}
	if(action == MenuAction_End)
	{
		delete menu;
	}
	if(action == MenuAction_Cancel)
	{
		if(index == MenuCancel_ExitBack)
		{
			GunsMenu(client);
		}
	}
}

/*
First menu
*/

public void ChooseGun(int client)
{
	if(IsValidClient(client))
	{
		if(g_bUseable[client])
		{
			Menu menu = new Menu(mChooseGun);
			menu.SetTitle("Choose gun");
			for(int wep; wep < sizeof(g_cWeapons); wep++)
			{
				menu.AddItem(g_cWeapons[wep], g_cWeaponsNames[wep]);
			}
			menu.ExitBackButton = true;
			menu.Display(client, 25);
		}
		else
		{
			PrintToChat(client, "%t", "OnceTime");
		}
	}
	else
	{
		PrintToChat(client, "%t", "Alive");
	}
}

public int mChooseGun(Menu menu, MenuAction action, int client, int index)
{
	if(action == MenuAction_Select)
	{
		if(IsValidClient(client, true))
		{
			if(g_bUseable[client])
			{
				char szItem[12];
				menu.GetItem(index, szItem, sizeof(szItem));
				g_bUseable[client] = true;
				GivePlayerItem(client, szItem);
			}
			else
			{
				PrintToChat(client, "%t", "OnceTime");
			}
		}
		else
		{
			PrintToChat(client, "%t", "Alive");
		}
	}
	if(action == MenuAction_End)
	{
		delete menu;
	}
	if(action == MenuAction_Cancel)
	{
		if(index == MenuCancel_ExitBack)
		{
			GunsMenu(client);
		}
	}
}

/*
Events
*/

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	for(int i = 1; i <= MaxClients; i++)
	{
		if(IsValidClient(i, true))
		{
			g_bUseable[i] = false;
			g_bChoosed[i] = false;
			GunsMenu(i);
			CreateTimer(15.0, Timer_DisableGunsCMD, GetClientUserId(i));
			StripWeapons(i);
			
			if(g_bChoosed[i])
			{
				GivePlayerItem(i, g_cChoosedGunP[i]);
			}
		}
	}
}

/*
Timers
*/

public Action Timer_DisableGunsCMD(Handle timer, any client)
{
	if(IsValidClient(client))
	{
		g_bUseable[client] = true;
		
		return Plugin_Stop;
	}
	
	return Plugin_Stop;
}

/*
Booleans + functions
*/

stock void StripWeapons(int client)
{
	int wepIdx;
	for (int x = 0; x <= 5; x++)
	{
		if (x != 2 && (wepIdx = GetPlayerWeaponSlot(client, x)) != -1)
		{
			RemovePlayerItem(client, wepIdx);
			RemoveEdict(wepIdx);
		}
	}
	int knife = GetPlayerWeaponSlot(client, CS_SLOT_KNIFE);
	EquipPlayerWeapon(client, knife);
}

stock bool IsValidClient(int client, bool alive = false)
{
	if(client >= 1 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client) && (alive == false || IsPlayerAlive(client)))
	{
		return true;
	}
	return false;
}