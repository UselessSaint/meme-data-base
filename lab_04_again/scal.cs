using Microsoft.SqlServer.Server;  
using System.Data.SqlClient;  
  
public class Scal
{
    [SqlFunction(DataAccess = DataAccessKind.Read)] 
    public static int amountOfOrders()
    {
        using (SqlConnection conn = new SqlConnection("context connection=true"))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand(
                "select count(*) from OrderInfo", conn);
            return (int)cmd.ExecuteScalar();
        }
    }
}