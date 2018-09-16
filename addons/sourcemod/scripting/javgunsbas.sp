#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Javierko"
#define PLUGIN_VERSION "1.0.2"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include <sdkhooks>

bool g_bUseable[MAXPLAYERS + 1] = false;
char g_cChoosedGunP[MAXPLAYERS + 1][32];

char g_cChoosedGunStartP[MAXPLAYERS + 1][32];
char g_cChoosedGunStartS[MAXPLAYERS + 1][32];

bool g_bChoosed[MAXPLAYERS + 1] = false;

ConVar g_cvOrder;

char g_cWeapons[][] =
{
	"weapon_ak47", "weapon_aug", "weapon_awp", "weapon_bizon", "weapon_famas",
	"weapon_g3sg1", "weapon_galilar", "weapon_m249", "weapon_m4a1",
	"weapon_mac10", "weapon_mag7", "weapon_mp5sd", "weapon_mp7", "weapon_mp9", "weapon_negev", "weapon_p90",
	"weapon_scar20", "weapon_sg556", "weapon_ssg08", "weapon_ump45", "weapon_xm1014"
};

char g_cWeapons1[][] =
{
	"weapon_ak47", "weapon_m4a1", "weapon_awp", "weapon_m4a1_silencer",
	"weapon_famas", "weapon_galilar", "weapon_sg556", "weapon_aug",
	"weapon_scar20", "weapon_g3sg1", "weapon_mp7", "weapon_mp9", "weapon_p90",
	"weapon_ssg08", "weapon_mag7", "weapon_nova", "weapon_ump45", "weapon_xm1014", "weapon_mp5sd", "weapon_m249", "weapon_negev"
};

char g_cWeaponsNames1[][] =
{
	"AK-47", "M4A4", "AWP", "M4A1-S",
	"Famas", "Galil", "SG556", "AUG",
	"SCAR-20", "G3SG1", "MP7", "MP9", "P90",
	"Scout", "Mag-7", "Nova", "UMP-45", "XM1014", "MP5", "M-249", "Negev"
};

char g_cWeaponsS[][] =  { "weapon_deagle", "weapon_usp_silencer", "weapon_glock", "weapon_p250", "weapon_fiveseven", "weapon_tec9", "weapon_hkp2000", "weapon_revolver" };
char g_cWeaponsSNames[][] =  { "Deagle", "USP-S", "Glock-18", "P250", "Five-Seven", "Tec-9", "P2000", "Revolver" };

char g_cWeaponsNames[][] =
{
	"AK-47", "AUG", "AWP", "Bizon", "Famas",
	"G3SG1", "Galil", "M-249", "M4A4",
	"Mac-10", "MAG-7", "MP5", "MP7", "MP9", "Negev", "P90",
	"SCAR-20", "Scout", "SSG 08", "UMP-45", "XM1014"
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
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("player_spawn", Event_PlayerSpawn);
	
	//Cvars
	g_cvOrder = CreateConVar("sm_gunspl_menuorder", "0", "1 - Order by useable, 0 - order by alphabeth", _, true, 0.0, true, 1.0);
	
	//Translations
	LoadTranslations("javguns.phrases");
	
	//File with cvars
	AutoExecConfig(true, "JavGuns");
}

public void OnMapStart()
{
	for(int i = 1; i <= MaxClients; i++)
	{
		g_bChoosed[i] = false;
	}
}

public Action Command_Guns(int client, int args)
{
	if(IsValidClient(client, true))
	{
		if(!g_bUseable[client])
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
		if(!g_bUseable[client])
		{
			Menu menu = new Menu(mGunsMenu);
			menu.SetTitle("%t", "MenuTitleChooseOption");
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
			if(!g_bUseable[client])
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
	if(IsValidClient(client, true))
	{
		if(!g_bUseable[client])
		{
			Menu menu = new Menu(mChooseGun);
			menu.SetTitle("%t", "MenuChoosePrim");
			if(g_cvOrder.IntValue == 0)
			{
				for(int wep; wep < sizeof(g_cWeapons); wep++)
				{
					menu.AddItem(g_cWeapons[wep], g_cWeaponsNames[wep]);
				}
			}
			else if(g_cvOrder.IntValue == 1)
			{
				for(int wep; wep < sizeof(g_cWeapons1); wep++)
				{
					menu.AddItem(g_cWeapons1[wep], g_cWeaponsNames1[wep]);
				}	
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
			if(!g_bUseable[client])
			{
				char szItem[64];
				menu.GetItem(index, szItem, sizeof(szItem));
				Format(g_cChoosedGunStartP[client], sizeof(g_cChoosedGunStartP[]), szItem);
				ChooseSStableGun(client);
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


public void ChooseSStableGun(int client)
{
	if(IsValidClient(client, true))
	{
		if(!g_bUseable[client])
		{
			Menu menu = new Menu(mChooseSStableGun);
			menu.SetTitle("%t", "MenuChooseSec");
			for(int wep; wep < sizeof(g_cWeaponsS); wep++)
			{
				menu.AddItem(g_cWeaponsS[wep], g_cWeaponsSNames[wep]);
			}
			menu.ExitButton = false;
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

public int mChooseSStableGun(Menu menu, MenuAction action, int client, int index)
{
	if(action == MenuAction_Select)
	{
		if(IsValidClient(client, true))
		{
			if(!g_bUseable[client])
			{
				char szItem[64];
				menu.GetItem(index, szItem, sizeof(szItem));
				
				Format(g_cChoosedGunStartS[client], sizeof(g_cChoosedGunStartS[]), szItem);
				
				int iSecWep;
				int iPrimWep;
				
				if ((iSecWep = GetPlayerWeaponSlot(client, CS_SLOT_SECONDARY)) != -1)
				{
					SDKHooks_DropWeapon(client, iSecWep, NULL_VECTOR, NULL_VECTOR);
					AcceptEntityInput(iSecWep, "Kill");							
				}
				if((iPrimWep = GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY)) != -1)
				{
					SDKHooks_DropWeapon(client, iPrimWep, NULL_VECTOR, NULL_VECTOR);
					AcceptEntityInput(iPrimWep, "Kill");
				}
				
				GivePlayerItem(client, g_cChoosedGunStartS[client]);
				GivePlayerItem(client, g_cChoosedGunStartP[client]);
				
				g_bUseable[client] = true;
				g_bChoosed[client] = true;
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
First menus
*/

public void ChooseSGun(int client)
{
	if(IsValidClient(client, true))
	{
		if(!g_bUseable[client])
		{
			Menu menu = new Menu(mChooseSGun);
			menu.SetTitle("%t", "MenuChooseSec");
			for(int wep; wep < sizeof(g_cWeaponsS); wep++)
			{
				menu.AddItem(g_cWeaponsS[wep], g_cWeaponsSNames[wep]);
			}
			menu.ExitButton = false;
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

public int mChooseSGun(Menu menu, MenuAction action, int client, int index)
{
	if(action == MenuAction_Select)
	{
		if(IsValidClient(client, true))
		{
			if(!g_bUseable[client])
			{
				char szItem[64];
				menu.GetItem(index, szItem, sizeof(szItem));
				
				int iSecWep;
				int iPrimWep;
				
				if ((iSecWep = GetPlayerWeaponSlot(client, CS_SLOT_SECONDARY)) != -1)
				{
					SDKHooks_DropWeapon(client, iSecWep, NULL_VECTOR, NULL_VECTOR);
					AcceptEntityInput(iSecWep, "Kill");							
				}
				if((iPrimWep = GetPlayerWeaponSlot(client, CS_SLOT_PRIMARY)) != -1)
				{
					SDKHooks_DropWeapon(client, iPrimWep, NULL_VECTOR, NULL_VECTOR);
					AcceptEntityInput(iPrimWep, "Kill");
				}
				
				GivePlayerItem(client, szItem);
				GivePlayerItem(client, g_cChoosedGunP[client]);
				
				g_bUseable[client] = true;
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

public void ChooseGun(int client)
{
	if(IsValidClient(client, true))
	{
		if(!g_bUseable[client])
		{
			Menu menu = new Menu(mChooseGun);
			menu.SetTitle("%t", "MenuChoosePrim");
			if(g_cvOrder.IntValue == 0)
			{
				for(int wep; wep < sizeof(g_cWeapons); wep++)
				{
					menu.AddItem(g_cWeapons[wep], g_cWeaponsNames[wep]);
				}
			}
			else if(g_cvOrder.IntValue == 1)
			{
				for(int wep; wep < sizeof(g_cWeapons1); wep++)
				{
					menu.AddItem(g_cWeapons1[wep], g_cWeaponsNames1[wep]);
				}	
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
			if(!g_bUseable[client])
			{
				char szItem[64];
				menu.GetItem(index, szItem, sizeof(szItem));
				Format(g_cChoosedGunP[client], sizeof(g_cChoosedGunP[]), szItem);
				ChooseSGun(client);
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

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if(IsValidClient(client))
	{
		g_bUseable[client] = false;
		if(g_bChoosed[client])
		{
			GivePlayerItem(client, g_cChoosedGunStartS[client]);
			GivePlayerItem(client, g_cChoosedGunStartP[client]);
		}
	}
}

public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
	int victim = GetClientOfUserId(GetEventInt(event, "userid"));
	
	if(IsValidClient(victim))
	{
		g_bUseable[victim] = false;
	}
}

public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	CreateTimer(15.0, Timer_DisableGunsCMD);
	for(int i = 1; i <= MaxClients; i++)
	{
		if(IsValidClient(i))
		{
			g_bUseable[i] = false;
			GunsMenu(i);
			StripWeapons(i);
		}
	}
}

/*
Timers
*/

public Action Timer_DisableGunsCMD(Handle timer)
{
	for(int i = 1; i <= MaxClients; i++)
	{
		if(IsValidClient(i))
		{
			g_bUseable[i] = true;
			
			return Plugin_Stop;
		}
	}
	
	return Plugin_Continue;
}

/*
Booleans + functions
*/

stock void StripWeapons(int client)
{
	if(IsValidClient(client))
	{
		int wepIdx;
		for (int x = 0; x <= 5; x++)
		{
			if (x != CS_SLOT_KNIFE && x != CS_SLOT_C4 && (wepIdx = GetPlayerWeaponSlot(client, x)) != -1)
			{
				RemovePlayerItem(client, wepIdx);
				RemoveEdict(wepIdx);
			}
		}
	}
}

stock bool IsValidClient(int client, bool alive = false)
{
	if(client >= 1 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client) && (alive == false || IsPlayerAlive(client)))
	{
		return true;
	}
	return false;
}