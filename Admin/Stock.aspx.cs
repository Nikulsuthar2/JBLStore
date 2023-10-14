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
    public partial class Stock : System.Web.UI.Page
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

        protected void rblStock_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            lblDataResult.Visible = false;
            if (rblStock.SelectedIndex == 0)
            {
                Repeater1.DataSource = SqlDataSource1;
                Repeater1.DataBind();
            }
            else if (rblStock.SelectedIndex == 1)
            {
                Repeater1.DataSource = dsInStock;
                Repeater1.DataBind();
            }
            else if (rblStock.SelectedIndex == 2)
            {
                Repeater1.DataSource = dsOutOfStock;
                Repeater1.DataBind();
            }
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            if (txtSearch.Text != "")
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    SqlCommand cmd;
                    if (rblStock.SelectedIndex == 1)
                    {
                        cmd = new SqlCommand("SELECT a.modelid, a.image, a.name, b.qty FROM product_dtl AS a INNER JOIN stock AS b ON a.modelid = b.modelid WHERE (a.modelid like '%" + txtSearch.Text + "%' or a.name like '%" + txtSearch.Text + "%') and (b.qty > 0)", con);
                    }
                    else if (rblStock.SelectedIndex == 2)
                    {
                        cmd = new SqlCommand("SELECT a.modelid, a.image, a.name, b.qty FROM product_dtl AS a INNER JOIN stock AS b ON a.modelid = b.modelid WHERE (a.modelid like '%" + txtSearch.Text + "%' or a.name like '%" + txtSearch.Text + "%') and (b.qty = 0)", con);
                    }
                    else
                    {
                        cmd = new SqlCommand("SELECT a.modelid, a.image, a.name, b.qty FROM product_dtl AS a INNER JOIN stock AS b ON a.modelid = b.modelid WHERE (a.modelid like '%" + txtSearch.Text + "%' or a.name like '%" + txtSearch.Text + "%') ", con);
                    }
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    sda.Fill(ds);
                    con.Close();
                    if(ds.Tables[0].Rows.Count > 0)
                    {
                        lblDataResult.Visible = false;
                        Repeater1.DataSource = ds;
                        Repeater1.DataBind();
                    }
                    else
                    {
                        lblDataResult.Visible = true;
                    }
                }
            }
            else
            {
                rblStock.SelectedIndex = 0;
                Repeater1.DataSource = SqlDataSource1;
                Repeater1.DataBind();
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "updateStock")
            {
                Response.Redirect("UpdateStock.aspx?modelid=" + e.CommandArgument.ToString());
            }
        }
    }
}