using JBLStore.Modules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace JBLStore.User
{
    public partial class Bill : System.Web.UI.Page
    {
        UserMethod um = new UserMethod();
        DataRow userData, orderData;

        int qty = 0;
        double amt = 0.0;
        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblqty = (Label)e.Item.FindControl("lblPQty");
                Label lblamt = (Label)e.Item.FindControl("lblPAmt");
                qty += int.Parse(lblqty.Text);
                amt += double.Parse(lblamt.Text);
            }
            if(e.Item.ItemType == ListItemType.Footer)
            {
                Label totqty = (Label)e.Item.FindControl("lblTotalQty");
                Label totamt = (Label)e.Item.FindControl("lblTotalAmt");

                totqty.Text = qty.ToString();
                totamt.Text = "&#8377;" + amt.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["uid"] != null)
            {
                if(Request.QueryString["oid"] != null)
                {
                    lblbillDate.Text = "Generated on " + DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss:tt");
                    userData = um.getUserDetails(Session["uid"].ToString());
                    lblCName.Text = userData["name"].ToString();
                    lblCEmail.Text = "Email : "+userData["email"].ToString();
                    lblCMobile.Text = "Mobile No. : " + userData["mobileno"].ToString();
                    lblAddress.Text = "Address : " + userData["address"].ToString();

                    orderData = um.getOrderData(Request.QueryString["oid"].ToString());
                    lblOid.Text = "Order ID : "+orderData["oid"].ToString();
                    lblOrderDate.Text = "Order Date : " + orderData["datetime"].ToString();
                    lblOStatus.Text = "Status : " + orderData["status"].ToString();
                }
                else
                {
                    Response.Redirect("UserProfile.aspx");
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
            
        }
    }
}