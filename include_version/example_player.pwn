#include <a_samp>
#include <sscanf2>
#include <samp-chatbot>
#include <zcmd>

#define TR_FOR_PLAYER 1 // player
#define API_KEY "DO_HERE" // api key
#include <translator>

main(){}

public OnTranslateResponse(translate[], result[], const id)
{
#if TR_FOR_PLAYER == 1
	/*
	 * per-player
	 */
	 for (new i = 0; i < MAX_PLAYERS; i++) {
			format(response_save[id], sizeof(response_save[]), "%s",
									result); // save result to 'response_save[id]'
			SendClientMessage(id, -1, response_save[id]);
	}
#endif
} /* void */

public OnPlayerConnect(playerid)
{
	SelectLanguage("Russian", "English/US", playerid);
	return 1;
}

COMMAND:translate(playerid, params[])
{
    extract params -> new string:translate[144+1]; else return 1;
    RequestToChatBot(translate, playerid);
    return 1;
}

COMMAND:clearmemory(playerid)
{
#if TR_FOR_PLAYER == 0
    return SendClientMessage(playerid, -1, "Error: command not available!");
#endif
    TR_ClearMemory(playerid);
    return 1;
}

COMMAND:changelang(playerid, params[])
{
	extract params -> new string:lang_one[36], string:lang_two[36]; \
        else return SendClientMessage(playerid, -1, "changelang [lang_one] [lang_two]");
    SelectLanguage(lang_one, lang_two, playerid);
    return 1;
}
