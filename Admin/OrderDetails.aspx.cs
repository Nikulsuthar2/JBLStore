using JBLStore.Modules;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.Admin
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        DataRow orderData;
        DataRow userData;
        UserMethod um = new UserMethod();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["oid"] != null)
            {
                lblOid.Text = Request.QueryString["oid"].ToString();
                orderData = um.getOrderData(Request.QueryString["oid"].ToString());
                userData = um.getUserDetails(orderData["uid"].ToString());

                if (!IsPostBack)
                {
                    lblName.Text = orderData["cname"].ToString();
                    lblEmail.Text = userData["email"].ToString();
                    lblMobileNo.Text = orderData["contact"].ToString();
                    lblAddress.Text = orderData["address"].ToString();

                    ddlStatus.SelectedValue = orderData["status"].ToString();

                    if(ddlStatus.SelectedValue == "Completed")
                    {
                        ddlStatus.Enabled = false;
                        btnUpdate.Enabled = false;
                        btnUpdate.Visible = false;
                    }
                }
            }
            else
            {
                Response.Redirect("Orders.aspx");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if(um.updateOrderStatus(lblOid.Text, ddlStatus.SelectedValue))
            {
                Response.Write("<script>alert('Status Updated');location.href='Orders.aspx'</script>");
            }
            else
            {
                Response.Write("<script>alert('Status Not Updated')</script>");
            }
        }

        int totalQty = 0;
        double totalPrice = 0.00;
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                totalQty += Int32.Parse(((Label)e.Item.FindControl("lblQty") as Label).Text);
                totalPrice += Double.Parse(((Label)e.Item.FindControl("lblPrice") as Label).Text);
            }
            else if (e.Item.ItemType == ListItemType.Footer)
            {
                Label lbl1 = ((Label)e.Item.FindControl("totalQty") as Label);
                lbl1.Text = totalQty.ToString();
                ((Label)e.Item.FindControl("totalPrice") as Label).Text = "&#8377;" + totalPrice.ToString();
            }
        }
    }
}