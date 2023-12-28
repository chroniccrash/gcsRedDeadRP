import mariadb
import pymssql
from .ms import insertUser as insertUserMS, generateMSDataBlob
from .maria import generateMariaDataBlob



# from .maria import generateMariaDataBlob
# from .ms import generateMSDataBlob, insertUser

class Processor:
    mariaData = dict()
    msData = dict()
    mariaConnection = None
    msConnection = None

    def __init__(self, mariaConnection: mariadb.Connection, msConnection: pymssql.Connection):
        self.mariaConnection = mariaConnection
        self.msConnection = msConnection
        if (not self.mariaData):
            self.refreshData()

    def refreshData(self):
        self.mariaData = generateMariaDataBlob(self.mariaConnection)
        self.msData = generateMSDataBlob(self.msConnection)

    def generateSocietyBlob(self):
        result = {'society': list(), 'society_ledger': list()}
        #Generate society list
        for key in self.mariaData:
            print(key)

    def transferBankInventorySnapshots(self):
        pass
    def transferCharacterInventorySnapshots(self):
        pass
    def transferCharacters(self):
        pass
    def transferCharacterSnapshots(self):
        pass
    def transferItems(self):
        pass
    def transferitemTypes(self):
        pass
    def transferSocieties(self):
        mariaSocietyLedgers = dict()
        for bankUser in self.mariaData['bankUsers']:
            pass
        for character in self.mariaData['characters']:
            pass
        for society in self.mariaData['societyLedger']:
            pass
    def transferSocietyLedgerSnapshots(self):
        pass
    def transferUsers(self):
        mariaUsers = dict()

        # Generate information that is importable from mariadb
        # parse info from bankUsers
        for bankUser in self.mariaData['bankUsers']:
            mariaUsers[bankUser['identifier']] = {'identifier': bankUser['identifier'], 
                                             'steam_name': '',
                                             'handle_id': 0,
                                             'discord_id': 0,
                                             'lastLogin': []}
        for character in self.mariaData['characters']:
            if(character['identifier'] not in mariaUsers):
                mariaUsers[character['identifier']] = {'identifier': character['identifier'], 
                                                  'steam_name': character.get('steamname',''),
                                                  'handle_id': 0,
                                                  'discord_id': character.get('discordid', 0),
                                                  'lastLogin': character.get('lastjoined','')}
            else:   
                mariaUsers[character['identifier']].update({'steam_name':character.get('steamname',''),
                                                       'handle_id': 0,
                                                       'discord_id': character.get('discordid', 0),
                                                       'lastLogin': character.get('lastjoined','')})
            # To-Do: lastLogin needs to take into account which character was last on, not just which was last processed.
        for society in self.mariaData['societyLedger']:
            pass
        
        msUsers = dict()
        for user in self.msData['users']:
            msUsers[user['id']] = user
        changes = False
        for key in mariaUsers:
            if(key not in msUsers):
                changes = True
                insertUserMS(self.msConnection, mariaUsers[key])
            else:
                #To-Do: Check for updates
                pass
        if(changes):
            self.msConnection.commit()
        self.refreshData()
