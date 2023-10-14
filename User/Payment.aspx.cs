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
    public partial class Payment : System.Web.UI.Page
    {
        int totalQty = 0;
        double totalPrice = 0.00;
        UserMethod um = new UserMethod();
        DataRow userdt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] != null)
            {
                userdt = um.getUserDetails(Session["uid"].ToString());
                if (Request.QueryString["cart"] != null)
                {
                    if (!IsPostBack)
                    {
                        Repeater1.DataSource = OrderSummary;
                        Repeater1.DataBind();
                        
                        lblAdress.Text = userdt["address"].ToString();
                    }
                }
                if (Request.QueryString["pid"] != null)
                {
                    if (!IsPostBack)
                    {
                        lblPid.Text = Request.QueryString["pid"].ToString();
                        Repeater1.DataSource = SingleProduct;
                        Repeater1.DataBind();

                        lblAdress.Text = userdt["address"].ToString();
                    }
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
                totalQty += Int32.Parse(((Label)e.Item.FindControl("lblQty") as Label).Text);
                totalPrice += Double.Parse(((Label)e.Item.FindControl("lblPrice") as Label).Text);
            }
            else if(e.Item.ItemType == ListItemType.Footer)
            {
                Label lbl1 = ((Label)e.Item.FindControl("totalQty") as Label);
                lbl1.Text = totalQty.ToString();
                ((Label)e.Item.FindControl("totalPrice") as Label).Text = "&#8377;" + totalPrice.ToString();
                lblTotalPrice.Text = totalPrice.ToString();
                lblTotalItem.Text = totalQty.ToString();
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            if (Session["uid"] != null)
            {
                //Response.Write(txtCName.Text + " " + txtContact.Text+" "+txtCAddress.Text);
                btnPay.Enabled = false;
                if (Request.QueryString["cart"] != null)
                {
                    if (um.payCartOrder(Session["uid"].ToString(), lblTotalPrice.Text, lblTotalItem.Text))
                    {
                        Response.Write("<script>alert('Order Successfull');location.href='UserHome.aspx'</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Order failed')</script>");
                    }
                }
                if(Request.QueryString["pid"] != null)
                {
                    if (um.paySingleOrder(lblPid.Text, Session["uid"].ToString(), lblTotalPrice.Text, lblTotalItem.Text))
                    {
                        Response.Write("<script>alert('Order Successfull');location.href='UserHome.aspx'</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Order failed')</script>");
                    }
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }

        protected void btnEditAdd_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["cart"] != null)
            {
                Response.Redirect("UserProfile.aspx?cart=" + Request.QueryString["cart"].ToString());
            }
            if (Request.QueryString["pid"] != null)
            {
                Response.Redirect("UserProfile.aspx?pid=" + Request.QueryString["pid"].ToString());
            }
        }
    }
}