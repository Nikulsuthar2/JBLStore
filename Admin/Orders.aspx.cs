using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.Admin
{
    public partial class Orders : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("update order_dtl set status = 'Pending' where status = 'New'", con);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "viewOrder")
            {
                Response.Redirect("OrderDetails.aspx?oid=" + e.CommandArgument.ToString());
            }
        }
    }
}