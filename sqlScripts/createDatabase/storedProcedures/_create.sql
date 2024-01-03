PRINT 'CREATING STORED PROCEDURES: Started'

:r .\sqlScripts\createDatabase\storedProcedures\base\characterInventorySnapshotFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\charactersFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\characterSnapshotsFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\itemsFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\itemTypesFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\societiesFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\societyLedgerSnapshotsFunctions.sql -- societyLedgerSnapshots Functions
:r .\sqlScripts\createDatabase\storedProcedures\base\usersFunctions.sql -- user Functions

PRINT 'CREATING STORED PROCEDURES: Finished'