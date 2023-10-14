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
    public partial class Cart : System.Web.UI.Page
    {
        UserMethod um = new UserMethod();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["uid"] != null)
            {
                if (Request.QueryString["setqty"] != null)
                {
                    if (um.setQtyOfCartItm(Request.QueryString["pid"].ToString(), Request.QueryString["setqty"].ToString(), Session["uid"].ToString()))
                    {
                        Response.Redirect("Cart.aspx");
                    }
                }
                if (!IsPostBack)
                {
                    Repeater1.DataSource = cartData;
                    Repeater1.DataBind();
                    setPriceDetails();
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "cartDelete")
            {
                um.removeInCart(e.CommandArgument.ToString(), Session["uid"].ToString());
                Repeater1.DataSource = cartData;
                Repeater1.DataBind();
                setPriceDetails();
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if(e.Item.ItemType == ListItemType.Item ||e.Item.ItemType == ListItemType.AlternatingItem)
            {
                String pid = ((Label)e.Item.FindControl("lblpid") as Label).Text;
                int qnt = um.getStockByPid(pid);
                String qty = ((Label)e.Item.FindControl("lblqty") as Label).Text;
                DropDownList ddllist = ((DropDownList)e.Item.FindControl("ddlQty") as DropDownList);

                for(int i=1; i<=qnt; i++)
                {
                    if (i > 5)
                    {
                        break;
                    }
                    else
                    {
                        ddllist.Items.Add(i.ToString());
                    }
                }

                ddllist.SelectedValue = qty;
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserHome.aspx");
        }

        void setPriceDetails()
        {
            DataSet dt = um.getCartPriceDetails(Session["uid"].ToString());

            lblTotalPrice.Text = "&#8377;" + dt.Tables[0].Rows[0]["totprice"].ToString();
            lblTotalDcnt.Text = "-" + dt.Tables[0].Rows[0]["totdcnt"].ToString();
            lblTotalDcntPrice.Text = "&#8377;" + dt.Tables[0].Rows[0]["totdcntprice"].ToString();
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if(um.totalCartItem(Session["uid"].ToString()) > 0)
            {
                Response.Redirect("Payment.aspx?cart=1");
            }
            else
            {
                Response.Write("<script>alert('No product in cart')</script>");
            }
            
        }
    }
}