import app
app.ServerName = None

SRV1 = {
	"name":"|cffffd500|h Legendy2", #GOLD
	"host":"192.168.0.26",
	"auth1":30001,
	"ch1":30003,
	"ch2":30007,
	"ch3":30011,
	"ch4":30015,
}

STATE_NONE = "|cffFF0000|hOFFLINE" #RED

STATE_DICT = {
	0: "|cffFF0000|h....", #RED
	1: "|cff00ff00|hONLINE", #GREEN
	2: "|cffffff00|hBUSY", #YELLOW
	3: "|cffff8a08|hFULL" #ORANGE
}

SERVER1_CHANNEL_DICT = {
	0: {"key":10, "name":"|cffFFFFFF|hCH-1", "ip":SRV1["host"], "tcp_port":SRV1["ch1"], "udp_port":SRV1["ch1"], "state":STATE_NONE,},
	1: {"key":11, "name":"|cffFFFFFF|hCH-2", "ip":SRV1["host"], "tcp_port":SRV1["ch2"], "udp_port":SRV1["ch2"], "state":STATE_NONE,},
	2: {"key":12, "name":"|cffFFFFFF|hCH-3", "ip":SRV1["host"], "tcp_port":SRV1["ch3"], "udp_port":SRV1["ch3"], "state":STATE_NONE,},
	3: {"key":13, "name":"|cffFFFFFF|hCH-4", "ip":SRV1["host"], "tcp_port":SRV1["ch4"], "udp_port":SRV1["ch4"], "state":STATE_NONE,},
}

REGION_NAME_DICT = {
	0: SRV1["name"],
}

REGION_AUTH_SERVER_DICT = {
	0: {
		0: {"ip": SRV1["host"], "port": SRV1["auth1"],},
		1: {"ip": SRV1["host"], "port": SRV1["auth1"],},
		2: {"ip": SRV1["host"], "port": SRV1["auth1"],},
		3: {"ip": SRV1["host"], "port": SRV1["auth1"],},
	}
}

REGION_DICT = {
	0: {
		1: {"name": SRV1["name"], "channel": SERVER1_CHANNEL_DICT,},
	},
}

MARKADDR_DICT = {
	10: {"ip": SRV1["host"], "tcp_port": SRV1["ch1"], "mark": "10.tga", "symbol_path": "10",},
}

TESTADDR = {"ip": SRV1["host"], "tcp_port": SRV1["ch1"], "udp_port": SRV1["ch1"],}
