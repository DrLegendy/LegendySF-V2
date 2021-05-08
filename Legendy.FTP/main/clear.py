#!/usr/local/bin/python3
#### @martysama0134 start scripts ####
from subprocess import check_output as sp_co, call as sp_call, CalledProcessError as sp_CalledProcessError
from os import getcwd as os_getcwd, chdir as os_chdir

def fShell(szCmd, bRet=False):
	try:
		if bRet:
			return sp_co(szCmd, shell=True)[:-1]	# remove final \n
		else:
			return sp_call(szCmd, shell=True)
	except sp_CalledProcessError:
		return -1

def cleStart():
	## base
	from json import load as j_loads
	v_lst=(
		"p2p_packet_info.txt","packet_info.txt","profile.txt","stdout","syslog","syserr",
		"usage.txt","VERSION.txt","DEV_LOG.log","mob_count","*.core"
	)
	szPWD=os_getcwd()
	## clear files from alog
	with open("clear.list", "r") as fList:
		mList = j_loads(fList)
	for dic1 in mList:
		# goto alog path
		# print dic1["path"]
		os_chdir(dic1["path"])
		# clean files
		fShell("cat /dev/null > PTS")
		fShell("rm -rf log/* cores/*")
		# goto base again
		os_chdir(szPWD)
	## clean other logs
	with open("start.list", "r") as fList:
		mList = j_loads(fList)
	for dic1 in mList:
		# goto alog path
		# print dic1["path"]
		os_chdir(dic1["path"])
		fShell("echo --- delete inside '%s' ---"%dic1["path"])
		fShell("rm -fv %s"%" ".join(v_lst))
		# goto base again
		os_chdir(szPWD)

if __name__ == "__main__":
	cleStart()
#
