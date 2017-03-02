Notes on fixing corrupted master databases:

```sql
use master
EXEC sp_MSforeachtable 'DROP TABLE ?'
```

See
- https://www.sqlservercentral.com/Forums/Topic1471777-146-1.aspx
- https://connect.microsoft.com/SQLServer/feedback/details/773184/ssms-system-databases-node-does-not-show-tables
