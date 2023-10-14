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
    public partial class UpdateStock : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["modelid"] != null)
            {
                if (!IsPostBack)
                {
                    bindData(Request.QueryString["modelid"].ToString());
                }
            }
            else
            {

            }
        }

        void bindData(string modelid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select a.modelid, a.image, b.qty from product_dtl a, stock b where a.modelid = b.modelid and b.modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@modelid", modelid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    imgProduct.ImageUrl = ds.Tables[0].Rows[0]["image"].ToString();
                    lblPid.Text = ds.Tables[0].Rows[0]["modelid"].ToString();
                    lblQty.Text = ds.Tables[0].Rows[0]["qty"].ToString();
                }
            }
        }

        protected void btnSet_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update stock set qty = @qty where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@qty", txtQty.Text);
                cmd.Parameters.AddWithValue("@modelid", lblPid.Text);

                int res = cmd.ExecuteNonQuery();

                if(res > 0)
                {
                    Response.Write("<script>alert('Stocks updated');location.href='Stock.aspx'</script>");
                }
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update stock set qty = qty + @qty where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@qty", txtQty.Text);
                cmd.Parameters.AddWithValue("@modelid", lblPid.Text);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    Response.Write("<script>alert('Stocks added');location.href='Stock.aspx'</script>");
                }
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update stock set qty = qty - @qty where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@qty", txtQty.Text);
                cmd.Parameters.AddWithValue("@modelid", lblPid.Text);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    Response.Write("<script>alert('Stocks subtracted');location.href='Stock.aspx'</script>");
                }
            }
        }

        protected void btnBackStock_Click(object sender, EventArgs e)
        {
            Response.Redirect("Stock.aspx");
        }
    }
}