import mariadb
import sys

print("Starting")
try:
    conn = mariadb.connect(
        user='wolfie',
        password='fuckssheephard',
        host='192.168.182.129',
        port=3306,
        database='vorpv2',
    )
except mariadb.Error as e:
    print(f"{e}: Part 1")
    sys.exit(1)

print("Connected to Database")
cursor = conn.cursor()

currentLine = ""
problemChildren = list()
print("Opening file")
commandCount = 0
with open('society.sql','r',encoding="utf8") as file:
    sql_script = file.read()
    for cmd in sql_script.split(';'):
        if cmd.strip():
            try:
                cmd = cmd.strip()
                currentLine = cmd
                cursor.execute(cmd)
                conn.commit()
            except mariadb.Error as e:
                issue = {'issue':e, 'cmd':currentLine}
                problemChildren.append(issue)
                print("("+str(commandCount)+")"+str(e))
        commandCount+=1

print(len(problemChildren))
conn.close()