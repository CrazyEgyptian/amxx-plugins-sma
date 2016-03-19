/**
 *	Amx Show Ip - amx_showip.sma
 *	
 *	Based on Amx Showip v1.0 by Vicious Vixen from https://forums.alliedmods.net/showthread.php?t=197662
 *		@released: 10/06/2012 (dd/mm/yyyy)
 */
#include <amxmodx>
#include <amxmisc>

#define PLUGIN_NAME		"Amx Show Ip"
#define PLUGIN_VERSION	"2016.03.19"
#define PLUGIN_AUTHOR	"X"

public plugin_init()
{
	register_plugin(PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_AUTHOR);
	
	register_concmd("amx_showip", "ConCmd_ShowIp");
}

public ConCmd_ShowIp(id)
{
	static name[64];
	new players[32], userip[16], temp[150], num;
	get_players(players, num);
	
	console_print(id, "Lista de Ip-uri:");
	for(new i = 0; i < num; ++i) {
		temp = "";
		get_user_ip(players[i], userip, 16, 1);
		get_user_name(players[i], name, 64);
		
		if(strlen(name) > 20) {
			copy(name, 17, name);
			add(name, 64, "...");
		}
		
		new IPD[32];
		findip(userip,IPD);
		console_print(id, "[%d] %-32.30s %-16.15s", i++, name, userip);
	}
	console_print(id, "====================");
	
	return PLUGIN_CONTINUE;
}

public findip(sip[16], sdesc[32])
{
	new ipsubnet[16], RValue=0, uip[16], ippart1[12], ippart2[12], ippart3[12], ippart4[12];
	
	copy(uip, 16, sip) ;
	while(replace(uip, 16, ".", " ")) {}
	parse(uip, ippart1, 12, ippart2, 12, ippart3, 12, ippart4, 12);
	ipsubnet = "";
	add(ipsubnet, 16, ippart1);
	add(ipsubnet, 16, ".");
	add(ipsubnet, 16, ippart2);
	add(ipsubnet, 16, ".");
	add(ipsubnet, 16, ippart3);
	
	return RValue;
}
