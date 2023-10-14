using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.User
{
    public partial class UserSignup : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from user_dtl where email = @email", con);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text);

                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.HasRows)
                {
                    dr.Close();
                    cmd = new SqlCommand("insert into user_dtl(name,email,password,mobileno,address) values(@name,@email,@pass,@mobno,@adrs)", con);
                    cmd.Parameters.AddWithValue("@name", txtName.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@pass", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@mobno", txtMobno.Text);
                    cmd.Parameters.AddWithValue("@adrs", txtAddress.Text);

                    int res = cmd.ExecuteNonQuery();

                    if (res > 0)
                    {
                        con.Close();
                        Response.Redirect("UserLogin.aspx");
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