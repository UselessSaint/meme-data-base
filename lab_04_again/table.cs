using System;  
using System.Data.Sql;  
using Microsoft.SqlServer.Server;  
using System.Collections;  
using System.Data.SqlTypes;  
using System.Diagnostics;  

namespace pow2
{
    public class TableValuedFunction
    {
        [SqlFunction(FillRowMethodName = "GenerateIntervalFillRow")]

public static IEnumerable GenerateInterval(SqlInt32 To)
        {
            int[] items = new int[To.Value];
            
            int fst = 0;
            int snd = 1;
            
            for (int i = 0; i < To.Value; i++)
            {
                items[i] = fst;
                
                int cur = fst + snd;
                fst = snd;
                snd = cur;
                
                
            }
            
            return items;
        }

        public static void GenerateIntervalFillRow(object o, out SqlInt32 item)
        {
            item = new SqlInt32((int)o);
        }
    }
}