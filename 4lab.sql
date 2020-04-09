SELECT * FROM DBA_PDBS ORDER BY PDB_ID;

--2
SELECT NAME FROM v$database;


--3
select comp_id, comp_name, version, status from dba_registry;

--5
select name, open_mode from v$pdbs;