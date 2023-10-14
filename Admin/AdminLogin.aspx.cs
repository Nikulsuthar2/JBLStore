using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.Admin
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from admin_dtl where email = @email and password = @pass", con);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@pass", txtPassword.Text);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["email"].ToString() == txtEmail.Text
                        && ds.Tables[0].Rows[0]["password"].ToString() == txtPassword.Text)
                    {
                        Session["aid"] = ds.Tables[0].Rows[0]["admind"].ToString();
                        Session["aname"] = ds.Tables[0].Rows[0]["name"].ToString();
                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        lblResult.Text = "Email or password are incorrect.";
                    }
                }
                else
                {
                    lblResult.Text = "Email or password are incorrect.";
                }

            }
        }
    }
}