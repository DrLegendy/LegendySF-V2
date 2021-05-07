  __  __                     _  ____   ____               _
 |  \/  | _   _  ___   __ _ | ||___ \ |  _ \  _ __  ___  | |_  ___
 | |\/| || | | |/ __| / _` || |  __) || |_) || '__|/ _ \ | __|/ _ \
 | |  | || |_| |\__ \| (_| || | / __/ |  __/ | |  | (_) || |_| (_) |
 |_|  |_| \__, ||___/ \__, ||_||_____||_|    |_|   \___/  \__|\___/
          |___/          |_|

  ___________                                                _________________
_|MYSQL2PROTO|______________________________________________/BY MARTYSAMA0134|_
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  _______________________________________________________________________
 | ARGS | DESCRIPTION                                                    |
 |¯¯¯¯¯¯|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯|
 | -d   | debug flag; it will dump a .sql instead of connecting to mysql |
 |______|________________________________________________________________|
 | -i   | process item_proto                                             |
 | -m   | process mob_proto                                              |
 |______|________________________________________________________________|
 | -u   | unpack phase                                                   |
 | -p   | pack phase                                                     |
 |______|________________________________________________________________|

  o-----------------------------------------o
  | USAGE                                   |
  o-----------------------------------------o
  |   PROTO CLIENT -> SQL                   |
  |     [1] run Mysql2Proto_UnpackSql.bat   |
  o-----------------------------------------o
  |   PROTO CLIENT -> MYSQL                 |
  |     [1] edit Mysql2Proto.json           |
  |     [2] run Mysql2Proto_Unpack.bat      |
  o-----------------------------------------o
  |   MYSQL -> PROTO CLIENT                 |
  |     [1] edit Mysql2Proto.json           |
  |     [2] run Mysql2Proto_Pack.bat        |
  o-----------------------------------------o

  o-----------------------------------------------------------o
  | NOTE                                                      |
  o-----------------------------------------------------------o
  |   [1] The tool automatically detects the structure of the |
  |        following protos when extracting                   |
  |         [1] TItemTable_r152 (2007)                        |
  |         [2] TItemTable_r156 (2012)                        |
  |         [3] TItemTable_r158 (2016)                        |
  |         [4] TMobTable_r235 (2007)                         |
  |         [5] TMobTable_r255 (2011)                         |
  |         [6] TMobTable_r256 (2014)                         |
  |         [7] TMobTable_r262 (2015)                         |
  |         [8] TMobTable_r262 (2016BR)                       |
  |                                                           |
  |        These are all the structures that the officials    |
  |        have used in these years. They don't have a        |
  |        practical use if not for extraction.               |
  o-----------------------------------------------------------o
  |   [2] The tool use the default structures to pack the     |
  |        protos:                                            |
  |         [2] TItemTable_r156 (2012)                        |
  |         [5] TMobTable_r255 (2011)                         |
  o-----------------------------------------------------------o

___    __    __    _
 | |_||_    |_ |\|| \
 | | ||__   |__| ||_/
