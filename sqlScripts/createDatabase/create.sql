PRINT 'create.sql:'

use GayCowboyStuff;

-- PRINT 'CREATING DATABASE: Started'
-- :r .\createDatabase\createDb.sql
-- PRINT 'CREATING DATABASE: Complete'

PRINT 'DROPPING TABLES: Started'
:r .\sqlScripts\createDatabase\dropAllTables.sql
PRINT 'DROPPING TABLES: Complete'

PRINT 'CREATING TABLES: Started'
:r .\sqlScripts\createDatabase\createTable_users.sql
:r .\sqlScripts\createDatabase\createTable_itemTypes.sql
:r .\sqlScripts\createDatabase\createTable_items.sql
:r .\sqlScripts\createDatabase\createTable_characters.sql
:r .\sqlScripts\createDatabase\createTable_characterInventorySnapshots.sql
:r .\sqlScripts\createDatabase\createTable_characterSnapshots.sql
:r .\sqlScripts\createDatabase\createTable_bankInventorySnapshots.sql
:r .\sqlScripts\createDatabase\createTable_societies.sql
:r .\sqlScripts\createDatabase\createTable_societyLedgerSnapshots.sql
PRINT 'CREATING TABLES: Completed'