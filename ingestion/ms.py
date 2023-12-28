import pymssql

def insertBankInventorySnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertCharacter(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertCharacterInventorySnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertCharacterSnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertItem(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertItemType(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertSociety(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertSocietyLedgerSnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def insertUser(dbConnection: pymssql.Connection, userData:dict()):
    cursor = dbConnection.cursor()
    cmd = """
    INSERT INTO dbo.users (id, steam_name, handle_id, discord_id, email_id) VALUES 
        ('{identifier}', '{steam_name}', '{handle_id}', '{discordid}', '{emailid}');
    """.format(identifier   = userData.get('identifier', ''),
               steam_name   = userData.get('steam_name', '').replace("'","''"),
               handle_id    = userData.get('handle_id', 0),
               discordid    = userData.get('discordid', 0),
               emailid      = userData.get('email_id', 0),
               )
    cursor.execute(cmd)

def getBankInventorySnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getCharacter(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getCharacterInventorySnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getCharacterSnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getItem(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getItemType(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getSociety(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getSocietyLedgerSnapshot(dbConnection: pymssql.Connection, data:dict()):
    raise NotImplementedError

def getUser(dbConnection: pymssql.Connection, userData:dict()):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.users WHERE

        ('{identifier}', '{steam_name}', '{}', '{}', '{}', '{}');
    """.format(identifier   = userData.get('identifier', ''),
               steam_name   = userData.get('steam_name', ''),
               handle_id    = userData.get('handle_id', 0),
               discordid    = userData.get('discordid', 0),
               emailid      = userData.get('email_id', 0),
               lastLogin    = userData.get('lastLogin', ''))
    cursor.execute(cmd)

def getBankInventorySnapshots(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.bankInventorySnapshots
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getCharacters(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.characters
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getCharacterInventorySnapshots(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.characterInventorySnapshots
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getCharacterSnapshots(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.characterSnapshots
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getItems(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.items
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getItemTypes(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.itemTypes
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getSocieties(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.societies
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getSocietyLedgerSnapshots(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.societyLedgerSnapshots
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def getUsers(dbConnection: pymssql.Connection):
    cursor = dbConnection.cursor()
    cmd = """
    SELECT * FROM dbo.users
    """
    cursor.execute(cmd)
    return cursor.fetchall()

def generateMSDataBlob(dbConnection: pymssql.Connection):
    result = dict({'bankInventorySnapshot':list(), 
                   'characters':list(), 
                   'characterInventorySnapshot': list(), 
                   'characterSnapshot': list(),
                   'items': list(),
                   'itemTypes': list(),
                   'societies': list(),
                   'societyLedgerSnapshot': list(),
                   'users': list()
                   })
    result['bankInventorySnapshot'] = getBankInventorySnapshots(dbConnection)
    result['characters'] = getCharacters(dbConnection)
    result['characterInventorySnapshot'] = getCharacterInventorySnapshots(dbConnection)
    result['characterSnapshot'] = getCharacterSnapshots(dbConnection)
    result['items'] = getItems(dbConnection)
    result['itemTypes'] = getItemTypes(dbConnection)
    result['societies'] = getSocieties(dbConnection)
    result['societyLedgerSnapshot'] = getSocietyLedgerSnapshots(dbConnection)
    result['users'] = getUsers(dbConnection)
    return result