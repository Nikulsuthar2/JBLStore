using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.Admin
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["aid"] != null)
            {
                if (Session["aname"] != null)
                {
                    lblAdminName.Text = Session["aname"].ToString();
                    lblAdminName.Visible = true;
                }
                else
                {
                    lblAdminName.Visible = false;
                }
                btnLogout.Visible = true;
            }
            else
            {
                lblAdminName.Visible = false;
                btnLogout.Visible = false;
                Response.Redirect("AdminLogin.aspx");
            }
            string url = Request.Path;
            if (url.Contains("Admin/Dashboard.aspx"))
            {
                hlDashboard.CssClass = "active";
                hlProduct.CssClass = "";
                hlStock.CssClass = "";
                hlUsers.CssClass = "";
                hlOrders.CssClass = "";
                hlSellReports.CssClass = "";
            }
            else if (url.Contains("Admin/Product.aspx")
                || url.Contains("Admin/AddProduct.aspx"))
            {
                hlDashboard.CssClass = "";
                hlProduct.CssClass = "active";
                hlStock.CssClass = "";
                hlUsers.CssClass = "";
                hlOrders.CssClass = "";
                hlSellReports.CssClass = "";
            }
            else if (url.Contains("Admin/Stock.aspx")|| url.Contains("Admin/UpdateStock.aspx"))
            {
                hlDashboard.CssClass = "";
                hlProduct.CssClass = "";
                hlStock.CssClass = "active";
                hlUsers.CssClass = "";
                hlOrders.CssClass = "";
                hlSellReports.CssClass = "";
            }
            else if (url.Contains("Admin/Customer.aspx"))
            {
                hlDashboard.CssClass = "";
                hlProduct.CssClass = "";
                hlStock.CssClass = "";
                hlUsers.CssClass = "active";
                hlOrders.CssClass = "";
                hlSellReports.CssClass = "";
            }
            else if (url.Contains("Admin/Orders.aspx") || url.Contains("Admin/OrderDetails.aspx"))
            {
                hlDashboard.CssClass = "";
                hlProduct.CssClass = "";
                hlStock.CssClass = "";
                hlUsers.CssClass = "";
                hlOrders.CssClass = "active";
                hlSellReports.CssClass = "";
            }
            else if (url.Contains("Admin/SalesReport.aspx"))
            {
                hlDashboard.CssClass = "";
                hlProduct.CssClass = "";
                hlStock.CssClass = "";
                hlUsers.CssClass = "";
                hlOrders.CssClass = "";
                hlSellReports.CssClass = "active";
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["aid"] = null;
            Session["aname"] = null;
            Response.Redirect("AdminLogin.aspx");
        }
    }
}