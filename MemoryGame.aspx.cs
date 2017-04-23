using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemoryGame : System.Web.UI.Page
{

    string SqlConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SQL_ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            QueryRank();
        }
        else
        {
            string parameter = Request["__EVENTTARGET"];
            switch (parameter)
            {
                case "CheckRank": CheckRank(); break;
                case "EnterRankings": EnterRankings(); break;
            }
        }
    }
    private void QueryRank()//查詢積分榜
    {
        string sql = "select ID,TIME,CONVERT(varchar(10),DATE,21)AS DATE from ASP.dbo.MemoryGame order by TIME";
        using (SqlConnection con = new SqlConnection(SqlConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = sql;
                con.Open();
                using (SqlDataAdapter sda = new SqlDataAdapter(sql, con))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        gvRank.DataSource = dt;
                        gvRank.DataBind();
                    }
                }
            }
        }
    }
    private void CheckRank()//檢查使用者該次成績能否進入積分榜
    {
        int time = int.Parse(Request["__EVENTArgument"]);
        string sql = @"select max(TIME)  from ASP.dbo.MemoryGame";
        using (SqlConnection con = new SqlConnection(SqlConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = sql;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    if (sdr.HasRows)
                    {
                        sdr.Read();
                        if (sdr.GetInt32(0) > time)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenDialog", "OpenEnterRankingsDialog();", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenDialog", " OpenCompleteDialog();", true);
                        }
                    }
                }

            }
        }
    }
    private void EnterRankings()//更新積分榜
    {
        string id = Request["__EVENTArgument"].Split('_')[0];
        string time = Request["__EVENTArgument"].Split('_')[1];
        string sql = @"update  ASP.dbo.MemoryGame set ID = @id , TIME = @time , DATE = @date 
                           where  TIME = (select max(TIME) from ASP.dbo.MemoryGame)";
        using (SqlConnection con = new SqlConnection(SqlConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = sql;
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@time", time);
                cmd.Parameters.AddWithValue("@date", DateTime.UtcNow);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        QueryRank();
    }
}
