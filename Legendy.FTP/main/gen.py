#!/usr/local/bin/python3
#### @martysama0134 start scripts ####
### TODO:
## clean how rawly CONFIG is shown in code
## find solution for common cores and not PORT.RANDOM ports
## separate database

from gen_settings import *

portlist={}
clearlist=[]
startlist=[]

def SlashFix(pathname):
	if v_system in ("FreeBSD", "Linux"):
		return pathname.replace("\\", "/")
	elif v_system=="Windows":
		return pathname.replace("/", "\\")
	return pathname

def CreateFolder(foldername):
	foldername = SlashFix(foldername)
	if v_system in ("FreeBSD", "Linux"):
		fShell("mkdir -p %s" % (foldername))
	elif v_system=="Windows":
		fShell("mkdir %s" % (foldername))

def CreateEmptyFile(filename):
	filename = SlashFix(filename)
	if v_system in ("FreeBSD", "Linux"):
		fShell("cat /dev/null > %s" % (filename))
	elif v_system=="Windows":
		fShell("type Nul > %s" % (filename))

def TouchFile(filename):
	filename = SlashFix(filename)
	if v_system in ("FreeBSD", "Linux"):
		fShell("touch %s" % (filename))
	elif v_system=="Windows":
		fShell("type Nul >> %s" % (filename))

def Append2File(txt, filename):
	filename = SlashFix(filename)
	fShell("echo %s >> %s" % (txt, filename))

def DeleteFile(filename):
	filename = SlashFix(filename)
	if v_system in ("FreeBSD", "Linux"):
		fShell("rm -rf %s" % (filename))
	elif v_system=="Windows":
		fShell("del /SF %s" % (filename))

def SymLinkCreate(src, dst, is_file):
	src = SlashFix(src)
	dst = SlashFix(dst)
	if v_system=="FreeBSD":
		fShell("ln -Ffnsw %s %s" % (src, dst))
	elif v_system=="Linux":
		fShell("ln -Ffns %s %s" % (src, dst))
	elif v_system=="Windows":
		if is_file:
			fShell("mklink %s %s" % (dst, src))
		else:
			fShell("mklink /D %s %s" % (dst, src))

def SymLinkCreateDir(src, dst):
	SymLinkCreate(src, dst, is_file=False)

def SymLinkCreateFile(src, dst):
	SymLinkCreate(src, dst, is_file=True)

def SymLinkCreateFileExe(src, dst):
	if v_system=="Windows":
		src+=".exe"
		dst+=".exe"
	SymLinkCreate(src, dst, is_file=True)

def WriteHostConfig(szConfFile, szGameName):
	Append2File("HOSTNAME: %s" % (szGameName), "%s" % (szConfFile))

def WriteChannelConfig(szConfFile, dwChannel):
	if dwChannel==M2TYPE.NOCHAN:
		dwChannel=1
	Append2File("CHANNEL: %u" % (dwChannel), "%s" % (szConfFile))

def WriteMapConfig(szConfFile, szMapList):
	if len(szMapList.split())>=32:
		print("WARNING: MORE THAN 32 MAPS INSIDE:", szConfFile)
	Append2File("MAP_ALLOW: %s" % (szMapList), "%s" % (szConfFile))

def WritePortConfig(szConfFile, wGenPort, dwType, dwPortType=None):
	if dwType==M2TYPE.DB:
		Append2File("%s = %u" % (PORT.lPORT[PORT.BIND_PORT], wGenPort), "%s" % (szConfFile))
	elif dwType==M2TYPE.CORE or dwType==M2TYPE.AUTH:
		Append2File("%s: %u" % (PORT.lPORT[dwPortType], wGenPort), "%s" % (szConfFile))

def genWriteConfig(szConfFile, tuSubConfTable):
	for val1 in tuSubConfTable:
		try:
			Append2File("%s" % ((val1[0] % val1[1])), "%s" % (szConfFile))
		except TypeError:
			print("WARNING: WRONG CONFIG OPTION FORMAT: %s" % str(val1))

def genMakeConfig(szConfFile, diConfTable, bIsExtra=False, dwType=None):
	genWriteConfig(szConfFile, diConfTable["general"])
	if bIsExtra:
		genWriteConfig(szConfFile, diConfTable["extra"])
	if dwType!=None:
		genWriteConfig(szConfFile, diConfTable[dwType])

def genGetRandPort(dwType):
	wTmpPort = PORT.RANDOMI
	while(True):
		if wTmpPort in portlist:
			wTmpPort+=1
			continue
		else:
			portlist[wTmpPort]=dwType
			break
	return wTmpPort

def genGenM2List():
	from json import dumps as j_dumps
	with open("start.list", "w") as fList: #b for unix end line
		fList.write(j_dumps(startlist, indent=4))
	with open("clear.list", "w") as fList: #b for unix end line
		fList.write(j_dumps(clearlist, indent=4))

def genGenIpfwList():
	def Joi(mList):
		return ' '.join(str(v) for v in mList)
	szRules=CustIpfwList%(Joi(udp_yes_ports), Joi(tcp_yes_ports), Joi(tcp_nop_ports))
	with open("ipfw.rules", "w") as fIpfw: #b for unix end line
		fIpfw.write(szRules)
		# fIpfw.write(szRules.replace("\r", ""))

def genInit():
	# clean port list
	global portlist
	portlist.clear()
	# clean start/clear list
	global startlist, clearlist
	del startlist[:]
	del clearlist[:]
	# clean ipfw list
	global udp_yes_ports,tcp_yes_ports,tcp_nop_ports
	del udp_yes_ports[:]
	del tcp_yes_ports[:]
	del tcp_nop_ports[:]

def genInitSrv(szSvr):
	#
	for val1 in ("share/data","share/locale","share/package","share/panama","share/conf","share/bin"):
		CreateFolder("%s/%s"%(szSvr, val1))
		# print "%s/%s"%(szSvr, val1)
	#
	for val1 in ("share/conf/BANIP","share/conf/CMD","share/conf/CRC","share/conf/VERSION","share/conf/state_user_count","share/bin/db","share/bin/game"):
		TouchFile("%s/%s" % (szSvr, val1))
		# print "%s/%s"%(szSvr, val1)
	#
	for val1 in ("share/conf/item_names.txt","share/conf/item_proto.txt","share/conf/mob_names.txt","share/conf/mob_proto.txt"):
		TouchFile("%s/%s" % (szSvr, val1))
		# print "%s/%s"%(szSvr, val1)
#global single server rules
genConfig = {}
genConfig["all"] = {}
#for ipfw rules
udp_yes_ports=[]
tcp_yes_ports=[]
tcp_nop_ports=[]

def genCalcParentRet(szParentName):
	return szParentName.count("/")*v_chanPath

def genMain(oSub={}, szParentName=[]):
	global genConfig
	global startlist, clearlist
	global udp_yes_ports, tcp_yes_ports, tcp_nop_ports
	if not oSub:
		oSub=M2S
		genInit()
	for v1 in oSub:
		k1=v1["name"]
		listTmpParentName=list(szParentName)	# list() to bypass variable passed by reference to value
		listTmpParentName.append(k1)
		szTmpParentName=("/".join(listTmpParentName))
		# DeleteFile("%s" % szTmpParentName) # completely unsafe
		CreateFolder("%s" % szTmpParentName)
		# print szTmpParentName
		if v1["type"]==M2TYPE.DB:
			k1s=genConfig["active"]
			#logs make paths
			CreateFolder("%s/%s/%s/cores" % (k1s, v_logFolder, szTmpParentName))
			CreateFolder("%s/%s/%s/log" % (k1s, v_logFolder, szTmpParentName))
			TouchFile("%s/%s/%s/PTS" % (k1s, v_logFolder, szTmpParentName))
			#logs sym paths
			SymLinkCreateDir("../%s/%s/cores" % (v_logFolder, szTmpParentName), "%s/cores" % (szTmpParentName))
			SymLinkCreateDir("../%s/%s/log" % (v_logFolder, szTmpParentName), "%s/log" % (szTmpParentName))
			SymLinkCreateFile("../%s/%s/PTS" % (v_logFolder, szTmpParentName), "%s/PTS" % (szTmpParentName))
			szDbName="%s-%s"%(genConfig["active"], k1)
			SymLinkCreateFileExe("../share/bin/db", "%s/%s" % (szTmpParentName,szDbName))
			#start/logs track
			startlist.append(
				{
					"path":szTmpParentName,
					"name":szDbName,
					"type":M2TYPE.DB,
					"chan":M2TYPE.NOCHAN,
					"serv":genConfig["active"],
				}
			)
			clearlist.append(
				{
					"path":"%s/%s/%s"%(k1s, v_logFolder, szTmpParentName),
					"type":M2TYPE.DB,
					"chan":M2TYPE.NOCHAN,
					"serv":genConfig["active"],
				}
			)
			#@item/mob protos .txt
			SymLinkCreateFile("../share/conf/item_names.txt", "%s/item_names.txt" % (szTmpParentName))
			SymLinkCreateFile("../share/conf/item_proto.txt", "%s/item_proto.txt" % (szTmpParentName))
			SymLinkCreateFile("../share/conf/mob_names.txt", "%s/mob_names.txt" % (szTmpParentName))
			SymLinkCreateFile("../share/conf/mob_proto.txt", "%s/mob_proto.txt" % (szTmpParentName))
			#@CONFIG details
			CreateEmptyFile("%s/conf.txt"%(szTmpParentName))
			genMakeConfig("%s/conf.txt"%szTmpParentName, v1["config"], genConfig["all"][genConfig["active"]]["isextra"])
			if v1["port"]==PORT.RANDOM:
				genConfig["all"][genConfig["active"]]["db_port"]=genGetRandPort(v1["type"])
			else:
				genConfig["all"][genConfig["active"]]["db_port"]=v1["port"]
			WritePortConfig("%s/conf.txt"%szTmpParentName, genConfig["all"][genConfig["active"]]["db_port"], v1["type"], PORT.BIND_PORT)
			#add to ipfw rules
			tcp_nop_ports.append(genConfig["all"][genConfig["active"]]["db_port"])
		elif v1["type"]==M2TYPE.CHANFOLDER or v1["type"]==M2TYPE.CHANNEL:
			if v1["type"]==M2TYPE.CHANNEL:
				genConfig["all"][genConfig["active"]]["chan"]=v1["chan"]
			if v1["type"]==M2TYPE.CHANFOLDER:
				genConfig["all"][genConfig["active"]]["mark"]="%s/mark"%szTmpParentName
				CreateFolder("%s" % genConfig["all"][genConfig["active"]]["mark"])
			genMain(v1["sub"], listTmpParentName)
		elif v1["type"]==M2TYPE.SERVER:
			genInitSrv(szTmpParentName)
			genConfig["active"]=v1["name"]
			genConfig["all"][v1["name"]]={}
			genConfig["all"][v1["name"]]["isextra"]=v1["isextra"]
			genConfig["all"][v1["name"]]["mark"]="%s/mark"%szTmpParentName
			genMain(v1["sub"], listTmpParentName)
		elif v1["type"]==M2TYPE.AUTH or v1["type"]==M2TYPE.CORE:
			k1s=genConfig["active"]
			#logs make paths
			CreateFolder("%s/%s/%s/cores" % (k1s, v_logFolder, szTmpParentName))
			CreateFolder("%s/%s/%s/log" % (k1s, v_logFolder, szTmpParentName))
			TouchFile("%s/%s/%s/PTS" % (k1s, v_logFolder, szTmpParentName))
			#logs sym paths
			gCPR=genCalcParentRet(szTmpParentName)
			SymLinkCreateDir("%s%s/%s/cores" % (gCPR,v_logFolder,szTmpParentName), "%s/cores" % (szTmpParentName))
			SymLinkCreateDir("%s%s/%s/log" % (gCPR,v_logFolder,szTmpParentName), "%s/log" % (szTmpParentName))
			SymLinkCreateFile("%s%s/%s/PTS" % (gCPR,v_logFolder,szTmpParentName), "%s/PTS" % (szTmpParentName))
			#dirs sym paths
			SymLinkCreateDir("%sshare/data" % (gCPR), "%s/data" % (szTmpParentName))
			SymLinkCreateDir("%sshare/locale" % (gCPR), "%s/locale" % (szTmpParentName))
			SymLinkCreateDir("%sshare/package" % (gCPR), "%s/package" % (szTmpParentName))
			SymLinkCreateDir("%sshare/panama" % (gCPR), "%s/panama" % (szTmpParentName))
			#files sym paths
			SymLinkCreateFile("%sshare/conf/CMD" % (gCPR), "%s/CMD" % (szTmpParentName))
			SymLinkCreateFile("%sshare/conf/CRC" % (gCPR), "%s/CRC" % (szTmpParentName))
			SymLinkCreateFile("%sshare/conf/VERSION" % (gCPR), "%s/VERSION" % (szTmpParentName))
			SymLinkCreateFile("%sshare/conf/state_user_count" % (gCPR), "%s/state_user_count" % (szTmpParentName))
			if v1["type"]==M2TYPE.AUTH:
				SymLinkCreateFile("%sshare/conf/BANIP" % (gCPR), "%s/BANIP" % (szTmpParentName))
			if v1["type"]==M2TYPE.AUTH:
				szGameName="%s-%s"%(genConfig["active"], k1)
			else:
				szGameName="%s-ch%u-%s"%(genConfig["active"], genConfig["all"][genConfig["active"]]["chan"], k1)
			#mark sym path
			if v1["type"]==M2TYPE.CORE:
				gCPR2=genCalcParentRet(genConfig["all"][genConfig["active"]]["mark"])
				SymLinkCreateDir("%smark" % gCPR2, "%s/mark" % (szTmpParentName))
			#core sym path
			SymLinkCreateFileExe("%sshare/bin/game" % (gCPR), "%s/%s" % (szTmpParentName, szGameName))
			#start/logs track
			if v1["type"]==M2TYPE.AUTH:
				kh1=M2TYPE.NOCHAN
			else:
				kh1=genConfig["all"][genConfig["active"]]["chan"]
			startlist.append(
				{
					"path":szTmpParentName,
					"name":szGameName,
					"type":v1["type"],
					"chan":kh1,
					"serv":genConfig["active"],
				}
			)
			clearlist.append(
				{
					"path":"%s/%s/%s"%(k1s, v_logFolder, szTmpParentName),
					"type":v1["type"],
					"chan":kh1,
					"serv":genConfig["active"],
				}
			)
			#@CONFIG details
			CreateEmptyFile("%s/CONFIG" % (szTmpParentName))
			genMakeConfig("%s/CONFIG"%szTmpParentName, v1["config"], genConfig["all"][genConfig["active"]]["isextra"], v1["type"])
			WriteHostConfig("%s/CONFIG"%szTmpParentName, szGameName)
			WriteChannelConfig("%s/CONFIG"%szTmpParentName, kh1)
			if not v1["type"]==M2TYPE.AUTH:
				WriteMapConfig("%s/CONFIG"%szTmpParentName, v1["maps"])
			# w/o array, only if
			wTmpPort={}
			# PORT process
			if v1["port"]==PORT.RANDOM:
				wTmpPort[PORT.PORT]=genGetRandPort(v1["type"])
			else:
				wTmpPort[PORT.PORT]=v1["port"]
			WritePortConfig("%s/CONFIG"%szTmpParentName, wTmpPort[PORT.PORT], v1["type"], PORT.PORT)
			# P2P_PORT process
			if v1["p2p_port"]==PORT.RANDOM:
				wTmpPort[PORT.P2P_PORT]=genGetRandPort(v1["type"])
			else:
				wTmpPort[PORT.P2P_PORT]=v1["p2p_port"]
			WritePortConfig("%s/CONFIG"%szTmpParentName, wTmpPort[PORT.P2P_PORT], v1["type"], PORT.P2P_PORT)
			# DB_PORT process
			wTmpPort[PORT.DB_PORT]=genConfig["all"][genConfig["active"]]["db_port"]
			WritePortConfig("%s/CONFIG"%szTmpParentName, wTmpPort[PORT.DB_PORT], v1["type"], PORT.DB_PORT)
			#add to ipfw rules
			if v1["type"]==M2TYPE.AUTH:
				udp_yes_ports.append(wTmpPort[PORT.PORT])
			tcp_yes_ports.append(wTmpPort[PORT.PORT])
			tcp_nop_ports.append(wTmpPort[PORT.P2P_PORT])
			pass
		else:
			print("unrecognized type %u"%v1["type"])
	#end

def genList(bIsVerbose=False):
	if bIsVerbose:
		print("startlist:")
		for i in startlist:
			print("---", i, "---")
		print("clearlist:")
		for i in clearlist:
			print("---", i, "---")
		print("udp_yes_ports:")
		for i in udp_yes_ports:
			print("---", i, "---")
		print("tcp_yes_ports:")
		for i in tcp_yes_ports:
			print("---", i, "---")
		print("tcp_nop_ports:")
		for i in tcp_nop_ports:
			print("---", i, "---")
	genGenM2List()
	genGenIpfwList()

def genGen():
	genMain()
	genList(True)


if __name__ == "__main__":
	genGen()
#



