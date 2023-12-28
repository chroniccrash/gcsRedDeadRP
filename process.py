import mariadb
import pymssql
import sys
import ingestion
import json

connectionKwargs = list()
connectionKwargs.append({'user':'wolfie',
                         'password':'fuckssheephard',
                         'host':'192.168.182.129',
                         'port':3306,
                         'database':'vorpv2'})
connectionKwargs.append({'user':'akelo',
                         'password':'TikiTojo163&ran13!#',
                         'host':'192.168.182.128',
                         'database':'GayCowboyStuff',
                         'as_dict':True})
try:
    conn = mariadb.connect(**connectionKwargs[0])
except mariadb.Error as e:
    print(f"{e}: failed with {connectionKwargs[0]}")
    sys.exit(1)
try:
    conn2 = pymssql.connect(**connectionKwargs[1])
except pymssql.Error as e:
    print(f"{e}: failed with {connectionKwargs[1]}")
    sys.exit(1)

# Transfer users from Maria to MSSql
processor = ingestion.Processor(conn, conn2)
processor.transferUsers()

conn.close()
conn2.close()