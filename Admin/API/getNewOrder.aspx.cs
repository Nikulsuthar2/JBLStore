using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.Admin.API
{
    public partial class getNewOrder : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("select count(*) from order_dtl where status = 'New'", con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    sda.Fill(ds);
                    Response.Write(ds.Tables[0].Rows[0][0].ToString());
                    con.Close();
                }
            }
        }
    }
}