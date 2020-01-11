using System;  
using System.Data;  
using System.Data.SqlTypes;  
using Microsoft.SqlServer.Server;  
using System.Text;  
  
[Serializable]  
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.Native,  
     IsByteOrdered=true, ValidationMethodName = "ValidateVector")]  
public struct Vector : INullable  
{  
    private bool is_Null;  
    private Int32 _x;  
    private Int32 _y; 
    private Int32 _z;
  
    public bool IsNull  
    {  
        get  
        {  
            return (is_Null);  
        }  
    }  
  
    public static Vector Null  
    {  
        get  
        {  
            Vector vct = new Vector();  
            vct.is_Null = true;  
            return vct;  
        }  
    }  
	
    public override string ToString()  
    {  
        if (this.IsNull)  
            return "NULL";  
        else  
        {  
            StringBuilder builder = new StringBuilder();  
            builder.Append(_x);  
            builder.Append(",");  
            builder.Append(_y);
            builder.Append(",");  
            builder.Append(_z);
            return builder.ToString();  
        }  
    }  
  
    [SqlMethod(OnNullCall = false)]  
    public static Vector Parse(SqlString s)  
    {
        if (s.IsNull)  
            return Null;  
  
        Vector vct = new Vector();  
        string[] xyz = s.Value.Split(",".ToCharArray());  
        vct.X = Int32.Parse(xyz[0]);  
        vct.Y = Int32.Parse(xyz[1]);  
        vct.Z = Int32.Parse(xyz[2]); 
  
        if (!vct.ValidateVector())   
            throw new ArgumentException("Invalid XYZ coordinate values.");  
        return vct;  
    }  
  
    public Int32 X  
    {  
        get  
        {  
            return this._x;  
        }  
        set   
        {  
            Int32 temp = _x;  
            _x = value;  
            if (!ValidateVector())  
            {  
                _x = temp;  
                throw new ArgumentException("Invalid X coordinate value.");  
            }  
        }  
    }  
  
    public Int32 Y  
    {  
        get  
        {  
            return this._y;  
        }  
        set  
        {  
            Int32 temp = _y;  
            _y = value;  
            if (!ValidateVector())  
            {  
                _y = temp;  
                throw new ArgumentException("Invalid Y coordinate value.");  
            }  
        }  
    }  
    
    public Int32 Z
    {  
        get  
        {  
            return this._z;  
        }  
        set  
        {  
            Int32 temp = _z;  
            _z = value;  
            if (!ValidateVector())  
            {  
                _z = temp;  
                throw new ArgumentException("Invalid Z coordinate value.");  
            }  
        }  
    }  
  
    private bool ValidateVector()  
    {  
        if ((_x >= 0) && (_y >= 0) && (_z >= 0))  
        {  
            return true;  
        }  
        else  
        {  
            return false;  
        }  
    }  

    [SqlMethod(OnNullCall = false)] 
    public Double Len()
    {
        return Math.Sqrt(Math.Pow(_x, 2.0) + Math.Pow(_y, 2.0) + Math.Pow(_z, 2.0));
    }
    
} 

















