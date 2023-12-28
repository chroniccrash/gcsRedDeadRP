import mariadb
import json

def getCharactersFromMariadb(dbConnection: mariadb.Connection):
    results = list()
    cursor = dbConnection.cursor()
    cmd = 'SELECT * from characters;'
    cursor.execute(cmd)
    for entry in cursor.fetchall():
        (identifier, steamname, charidentifier, group, money, gold, rol, xp, healthouter, healthinner, staminaouter, staminainner, hours, LastLogin, minexp, stonecutxp, inventory, job, status, firstname, lastname, skinPlayer, compPlayer, jobgrade, coords, isdead, clanid, trust, supporter, walk, crafting, info, gunsmith, ammo, discordid, lastjoined, moonshineenty, postbox, motel, meta, needs, UIposition, clan) = entry
        results.append({'identifier':identifier.strip(),'steamname':steamname.strip(), 'charidentifier':charidentifier, 'group':group.strip(),
                        'money':money, 'gold':gold, 'rol':rol, 'xp':xp, 'healthouter':healthouter, 'healthinner':healthinner, 
                        'staminaouter':staminaouter, 'staminainner':staminainner, 'hours':hours, 'LastLogin':LastLogin, 'minexp':minexp, 
                        'stonecutxp':stonecutxp, 'inventory':json.loads(inventory.strip()), 'job':job.strip(), 'status':json.loads(status.strip()),
                        'firstname':firstname.strip(), 'lastname':lastname.strip(), 'skinPlayer':json.loads(skinPlayer.strip()), 
                        'compPlayer':json.loads(compPlayer.strip()), 'jobgrade':jobgrade, 'coords':json.loads(coords.strip()), 
                        'isdead':isdead, 'clanid':clanid, 'trust':trust, 'supporter':supporter, 'walk':walk, 
                        'crafting':json.loads(crafting.strip()), 'info':json.loads(info.strip()), 'gunsmith':gunsmith, 'ammo':ammo, 'discordid':discordid, 
                        'lastjoined':json.loads(lastjoined.strip()), 'moonshineenty':json.loads(moonshineenty.strip()), 'postbox':postbox, 
                        'motel':motel, 'meta':json.loads(meta.strip()), 'needs':json.loads(needs.strip()), 'UIposition':json.loads(UIposition.strip()),
                        'clan':clan})
    return results

def getBankInventoryFromMariadb(dbConnection: mariadb.Connection):
    results = list()
    cursor = dbConnection.cursor()
    cmd = 'SELECT * from bank_users;'
    cursor.execute(cmd)
    for entry in cursor.fetchall():
        (id, name, identifier, charidentifier, money, gold, items, invspace) = entry
        results.append({'id':id,'name':name.strip(), 'identifier':identifier.strip(), 'charidentifier':charidentifier, 'money':money, 
                        'gold':gold, 'items':json.loads(items.strip()), 'invspace':invspace})
    return results

def getSocietyLedgerFromMariadb(dbConnection: mariadb.Connection):
    results = list()
    cursor = dbConnection.cursor()
    cmd = 'SELECT * from society_ledger;'
    cursor.execute(cmd)
    for entry in cursor.fetchall():
        (job, ledger) = entry
        results.append({'job':job.strip(),'ledger':ledger})
    return results

def generateMariaDataBlob(dbConnection: mariadb.Connection):
    result = dict({'bankUsers':list(), 'characters':list(), 'societyLedger': list(), })
    characters = getCharactersFromMariadb(dbConnection)
    for character in characters:
        result['characters'].append(character)
    bankInventories = getBankInventoryFromMariadb(dbConnection)
    for inventory in bankInventories:
        result['bankUsers'].append(inventory)
    societyLedgers = getSocietyLedgerFromMariadb(dbConnection)
    for ledger in societyLedgers:
        result['societyLedger'].append(ledger)
    return result
