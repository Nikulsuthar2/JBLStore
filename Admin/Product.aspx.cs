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
    public partial class Product : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Repeater1.DataSource = SqlDataSource1;
                Repeater1.DataBind();
            }
            
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddProduct.aspx");
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "deleteProduct")
            {
                bool res = deleteProduct(e.CommandArgument.ToString());
                if (res)
                {
                    Repeater1.DataBind();
                    Response.Write("<script>alert('" + e.CommandArgument.ToString() + " Deleted Successfully')</script>");
                    Response.Redirect("Product.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Not Deleted')</script>");
                }
            }
            if(e.CommandName == "editProduct")
            {
                //Response.Write("<script>alert('AddProduct.aspx?updtid=" + e.CommandArgument.ToString()+"')</script>");
                Response.Redirect("AddProduct.aspx?updtid=" + e.CommandArgument.ToString());
            }
        }

        bool deleteProduct(string modelid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select pid from product_dtl where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@modelid", modelid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                string pid = ds.Tables[0].Rows[0][0].ToString();


                cmd = new SqlCommand("delete from stock where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@modelid", modelid);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("delete from cart where pid = @pid", con);
                cmd.Parameters.AddWithValue("@pid", pid);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("delete from product_dtl where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@modelid", modelid);

                int res = cmd.ExecuteNonQuery();
                con.Close();

                if (res > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            if(txtSearch.Text != "")
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("select * from product_dtl where modelid like '%"+txtSearch.Text+"%' or name like '%"+ txtSearch.Text + "%'", con);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    sda.Fill(ds);
                    con.Close();
                    Repeater1.DataSource = ds;
                    Repeater1.DataBind();
                }
            }
            else
            {
                Repeater1.DataSource = SqlDataSource1;
                Repeater1.DataBind();
            }
        }
    }
}