using System;  
using System.Data;  
using System.Data.SqlClient;  
using System.Data.SqlTypes;  
using Microsoft.SqlServer.Server;  
  
[Serializable]  
[SqlUserDefinedAggregate(  
    Format.Native,  
    IsInvariantToDuplicates = false,  
    IsInvariantToNulls = true,  
    IsInvariantToOrder = true,  
    IsNullIfEmpty = true,  
    Name = "Dec")]  
    
public struct Dec
{
    private long dec;
    
    public void Init()
    {
        dec = 0;
    }
    
    public void Accumulate(SqlInt32 val)
    {
        if (!val.IsNull)
        {
            dec -= (long)val;
        }
    }
    
    public void Merge(Dec grp)
    {
        dec -= grp.dec;
    }
    
    public SqlInt32 Terminate()
    {
        int value = (int)dec;
        return new SqlInt32(value);
    }
}