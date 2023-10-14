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
    public partial class Dashboard : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            using(SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("select count(*) from product_dtl", con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
                lblTProduct.Text = ds.Tables[0].Rows[0][0].ToString();

                cmd = new SqlCommand("select count(*) from user_dtl", con);
                sda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sda.Fill(ds);
                lblTCustomer.Text = ds.Tables[0].Rows[0][0].ToString();

                cmd = new SqlCommand("select count(*) from order_dtl where status = 'New'", con);
                sda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sda.Fill(ds);
                lblNewOrder.Text = ds.Tables[0].Rows[0][0].ToString();

                cmd = new SqlCommand("select count(*) from order_dtl where status = 'Completed'", con);
                sda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sda.Fill(ds);
                lblOrderComplete.Text = ds.Tables[0].Rows[0][0].ToString();

                cmd = new SqlCommand("select sum(totalprice) from order_dtl where status = 'Completed'", con);
                sda = new SqlDataAdapter(cmd);
                ds = new DataSet();
                sda.Fill(ds);
                lblTotalEarn.Text = "&#8377; " + ds.Tables[0].Rows[0][0].ToString() == "" ? "0" : ds.Tables[0].Rows[0][0].ToString();

                con.Close();
            }
        }
    }
}