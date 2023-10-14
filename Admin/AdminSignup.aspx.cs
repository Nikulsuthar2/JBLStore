using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace JBLStore.Admin
{
    public partial class AdminSignup : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from admin_dtl where email = @email", con);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@pass", txtPassword.Text);

                SqlDataReader dr = cmd.ExecuteReader();

                if(!dr.HasRows)
                {
                    dr.Close();
                    cmd = new SqlCommand("insert into admin_dtl(name,email,password) values(@name,@email,@pass)", con);
                    cmd.Parameters.AddWithValue("@name", txtName.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@pass", txtPassword.Text);

                    int res = cmd.ExecuteNonQuery();

                    if(res > 0)
                    {
                        con.Close();
                        Response.Redirect("AdminLogin.aspx");
                    }
                    else
                    {
                        lblResult.Text = "some error.";
                    }
                }
                else
                {
                    lblResult.Text = "Email already exists.";
                }
                con.Close();
            }
        }
    }
}