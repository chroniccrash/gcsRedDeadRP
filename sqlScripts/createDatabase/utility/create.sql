PRINT 'create.sql:'

use GayCowboyStuff;

-- PRINT 'CREATING DATABASE: Started'
-- :r .\createDatabase\createDb.sql
-- PRINT 'CREATING DATABASE: Complete'

PRINT 'DROPPING TABLES: Started'
:r .\sqlScripts\createDatabase\utility\dropAllTables.sql
PRINT 'DROPPING TABLES: Complete'

PRINT 'CREATING TABLES: Started'
:r .\sqlScripts\createDatabase\tables\createTable_users.sql
:r .\sqlScripts\createDatabase\tables\createTable_itemTypes.sql
:r .\sqlScripts\createDatabase\tables\createTable_items.sql
:r .\sqlScripts\createDatabase\tables\createTable_characters.sql
:r .\sqlScripts\createDatabase\tables\createTable_characterInventorySnapshots.sql
:r .\sqlScripts\createDatabase\tables\createTable_characterSnapshots.sql
:r .\sqlScripts\createDatabase\tables\createTable_bankInventorySnapshots.sql
:r .\sqlScripts\createDatabase\tables\createTable_societies.sql
:r .\sqlScripts\createDatabase\tables\createTable_societyLedgerSnapshots.sql
PRINT 'CREATING TABLES: Completed'

PRINT 'CREATING STORED PROCEDURES: Started'
-- stored procedures
:r .\sqlScripts\createDatabase\storedProcedures\create\userFunctions.sql -- user table