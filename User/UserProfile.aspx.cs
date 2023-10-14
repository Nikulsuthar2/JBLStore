using JBLStore.Modules;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.User
{
    public partial class UserProfile : System.Web.UI.Page
    {
        UserMethod um = new UserMethod();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["uid"] != null)
            {
                if (Request.QueryString["cart"] != null)
                {
                    btnBTP.Visible = true;
                }
                else if (Request.QueryString["pid"] != null)
                {
                    btnBTP.Visible = true;
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater prep = ((Repeater)e.Item.FindControl("OrderProductRepeater") as Repeater);
                Label lbloid = ((Label)e.Item.FindControl("orderid"));
                string oid = lbloid.Text;
                DataSet orderline = um.getOrderLine(oid);
                prep.DataSource = orderline;
                prep.DataBind();
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "btnBill")
            {
                Response.Redirect("Bill.aspx?oid=" + e.CommandArgument.ToString());
            }
        }

        protected void btnBTP_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["cart"] != null)
            {
                Response.Redirect("Payment.aspx?cart=" + Request.QueryString["cart"].ToString());
            }
            if (Request.QueryString["pid"] != null)
            {
                Response.Redirect("Payment.aspx?pid=" + Request.QueryString["pid"].ToString());
            }
        }
    }
}