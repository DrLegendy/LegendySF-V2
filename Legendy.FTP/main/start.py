#!/usr/local/bin/python3
#### @martysama0134 start scripts ####
### TODO fix -s -w for srvr and not only channels
from subprocess import check_output as sp_co, call as sp_call, CalledProcessError as sp_CalledProcessError
from os import getcwd as os_getcwd, chdir as os_chdir

from platform import system as p_system
v_system = p_system()

class M2TYPE:
	SERVER, DB, AUTH, CHANFOLDER, CHANNEL, CORE = range(6)
	NOCHAN = 0

def fShell(szCmd, bRet=False):
	try:
		if bRet:
			return sp_co(szCmd, shell=True)[:-1]	# remove final \n
		else:
			return sp_call(szCmd, shell=True)
	except sp_CalledProcessError:
		return -1

def keyCheck(dict, key, elem={}):
	try:
		dict[key]
	except KeyError:
		dict[key]=elem

proclist={}
whichlist={"serv":[], "chan":[]}
def staInit():
	global proclist
	## base
	from json import load as j_loads
	with open("start.list", "r") as fList:
		mList = j_loads(fList)
	proclist.clear()
	for dic1 in mList:
		keyCheck(proclist, dic1["serv"])
		if dic1["type"]==M2TYPE.DB:
			keyCheck(proclist[dic1["serv"]], "db", [])
			proclist[dic1["serv"]]["db"].append(dic1)
		elif dic1["type"]==M2TYPE.AUTH or dic1["type"]==M2TYPE.CORE:
			keyCheck(proclist[dic1["serv"]], "core", [])
			proclist[dic1["serv"]]["core"].append(dic1)
			if dic1["type"]==M2TYPE.CORE:
				keyCheck(proclist[dic1["serv"]], "chan", set())
				proclist[dic1["serv"]]["chan"].add(dic1["chan"])

def staStart(serv=(), chan={}):
	from time import sleep as t_sleep
	szPWD=os_getcwd()
	global whichlist
	whichlist["serv"]=serv
	whichlist["chan"]=chan
	keyCheck(whichlist["chan"], "all", ())
	def RunInMe(tmpProcList, bSkipCheck=False):
		addFlags = ""
		if dwLogLevel:
			addFlags += " -l %d " % dwLogLevel
		if dwIP:
			addFlags += " -I %s " % dwIP

		for dic1 in tmpProcList:
			# skip not requested servers
			if (whichlist["serv"]) and (dic1["serv"] not in whichlist["serv"]):
				continue
			if not bSkipCheck and dic1["type"]==M2TYPE.CORE:
				# skip not requested channels
				keyCheck(whichlist["chan"], dic1["serv"], ())
				if whichlist["chan"]["all"]:
					# print "all",whichlist["chan"]["all"]
					if not dic1["chan"] in whichlist["chan"]["all"]:
						continue
				if whichlist["chan"][dic1["serv"]]:
					# print dic1["serv"]
					if not dic1["chan"] in whichlist["chan"][dic1["serv"]]:
						continue
			# print dic1

			if v_system in ("FreeBSD", "Linux"):
				if not fShell("""ps afx | fgrep "./%s" | fgrep -v grep | awk '{print $1}'"""%dic1["name"], True):
					# print dic1["name"], "not found"
					# goto process file
					# print("cd %s"%dic1["path"])
					os_chdir(dic1["path"])
					# set automatically the privs to the binaries
					fShell("chmod u+x %s" % (dic1["name"]))
					# start the processes
					fShell("./%s %s &" % (dic1["name"], addFlags))
					# goto base again
					os_chdir(szPWD)
			elif v_system=="Windows":
				# easy workaround for windows (only for debug purposes)
				# fShell("""tasklist /v | findstr "%s" """%dic1["name"])
				os_chdir(dic1["path"])
				fShell("start /b %s %s" % (dic1["name"], addFlags))
				os_chdir(szPWD)
	for k1 in proclist.keys():
		RunInMe(proclist[k1]["db"])
		# RunInMe(proclist[k1]["db"], True)
		t_sleep(3)
		RunInMe(proclist[k1]["core"])

if __name__ == "__main__":
	from getopt import getopt as g_getopt, GetoptError as g_GetoptError
	from sys import exit as s_exit, argv as s_argv
	try:
		bIsAll = True
		bHasPrompt = False
		# baseChan = [1,99] # ch1 and ch99 are required
		baseChan = []
		listWhich = []
		szWhichServ = ""
		szWhichChan = {}
		dwLogLevel = 0
		dwIP = ""
		optlist, args = g_getopt(s_argv[1:],"psl:I:",('prompt','selective','whichserv=','whichchan=','level=','IP='))
		for o, a in optlist:
			if o in ('-s', '--selective'):
				bIsAll=False
			elif o in ('-p', '--prompt'):
				bHasPrompt=True
			elif o in ('-l', '--level'):
				dwLogLevel=int(a)
			elif o in ('-I', '--IP'):
				dwIP=a
			elif o in ('-ws', '--whichserv'):
				szWhichServ=a
				if szWhichServ:
					bIsAll=False
			elif o in ('-wc', '--whichchan'):
				szWhichChan["all"]=a
				if szWhichChan:
					bIsAll=False
		staInit()
		if bHasPrompt:
			bIsAll=False
			print("Servers available to run:", " ".join(iter(proclist.keys())))
			szTmp1 = input("Enter which servers you want to start: (nothing=all)\ne.g. srv1 srv2 srv3\n>>> ")
			if szTmp1.strip():
				szWhichServ=szTmp1
				for iChan in szTmp1.strip().split():
					if iChan not in iter(proclist.keys()):
						print("Server not found:", iChan)
						continue
					print("Channels available to run for %s:"%iChan, " ".join([str(i) for i in proclist[iChan]["chan"]]))
					szTmp2 = input("Enter which additional channels you want to start: (nothing=all)\ne.g. 1 2 99\n>>> ")
					if szTmp2.strip():
						# print szTmp1, szTmp2
						szWhichChan[iChan]=szTmp2
		# print proclist,whichlist
		if bIsAll:
			staStart()
		else:
			tmpWhichServ,tmpWhichChan=[],{}
			# print "---",szWhichServ,"---"
			# print "---",szWhichChan,"---"
			if szWhichServ:
				tmpWhichServ=szWhichServ.split()
			if szWhichChan:
				for iKey in szWhichChan.keys():
					tmpWhichChan[iKey]=set([int(i) for i in szWhichChan[iKey].split()])
				# tmpWhichChan["all"]=list(set([int(i) for i in szWhichChan["all"].split()] + baseChan))
			# print tmpWhichServ, "\n", tmpWhichChan
			staStart(serv=tmpWhichServ, chan=tmpWhichChan)
	except g_GetoptError as err:
		s_exit(err)
#


