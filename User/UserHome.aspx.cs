using JBLStore.Modules;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.User
{
    public partial class UserHome : System.Web.UI.Page
    {
        String uid;
        UserMethod um = new UserMethod();
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["uid"] != null)
            {
                uid = Session["uid"].ToString();
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
            
            if (!IsPostBack)
            {
                setBigCard();
            }
        }

        void setBigCard()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select a.pid, a.image, a.name, a.description, a.price, a.discount, b.qty from product_dtl a, stock b where a.modelid = b.modelid  order by pid desc", con);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblBPid.Text = ds.Tables[0].Rows[0]["pid"].ToString();
                    imgBPImage.ImageUrl = ds.Tables[0].Rows[0]["image"].ToString();
                    lblBPName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    lblBPDesc.Text = ds.Tables[0].Rows[0]["description"].ToString();
                    lblBPPrice.Text = " &#8377;" + ds.Tables[0].Rows[0]["price"].ToString();
                    int dcnt = Int32.Parse(ds.Tables[0].Rows[0]["discount"].ToString());
                    if (dcnt > 0)
                    {
                        lblBPDiscount.Visible = true;
                        lblBPDcntPrice.Visible = true;
                        lblBPDiscount.Text = ds.Tables[0].Rows[0]["discount"].ToString() + "%";
                        lblBPPrice.Font.Strikeout = true;
                        lblBPDcntPrice.Text = "&#8377;"+ (Double.Parse(ds.Tables[0].Rows[0]["price"].ToString()) - (Double.Parse(ds.Tables[0].Rows[0]["price"].ToString()) * (Double.Parse(ds.Tables[0].Rows[0]["discount"].ToString()) / 100))).ToString();
                    }

                    if (um.isInCart(lblBPid.Text, uid))
                    {
                        btnBPatc.Visible = false;
                    }

                    if(Int32.Parse(ds.Tables[0].Rows[0]["qty"].ToString()) == 0)
                    {
                        btnBPatc.Visible = false;
                        btnBPbuy.Visible = false;
                        lblStock.Visible = true;
                    }
                }
            }
        }

        protected void btnBPatc_Click(object sender, EventArgs e)
        {
            if(um.addToCart(lblBPid.Text,uid))
            {
                Response.Redirect("UserHome.aspx");
            }
        }

        protected void btnBPbuy_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx?pid="+ lblBPid.Text);
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "buyProduct")
            {
                Response.Redirect("Payment.aspx?pid=" + e.CommandArgument.ToString());
            }
            if (e.CommandName == "atcProduct")
            {
                if (um.addToCart(e.CommandArgument.ToString(),uid))
                {
                    Repeater1.DataBind();
                    //Response.Redirect("UserHome.aspx");
                }
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                String pid = ((Label)e.Item.FindControl("lblSPid") as Label).Text;
                Label lbls = ((Label)e.Item.FindControl("lblInStock") as Label);
                Button btnatc = ((Button)e.Item.FindControl("btnSPatc") as Button);
                Button btnbuy = ((Button)e.Item.FindControl("btnSPBuy") as Button);

                if (um.isInCart(pid, uid))
                {
                    btnatc.Visible = false;
                    btnbuy.Width = Unit.Parse("100%");
                }
                else
                {
                    btnatc.Visible = true;
                }

                if (!um.isInStock(pid))
                {
                    btnatc.Visible = false;
                    btnbuy.Visible = false;
                    lbls.Visible = true;
                }
            }
        }

        protected void Repeater2_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "buyProduct")
            {
                Response.Redirect("Payment.aspx?pid=" + e.CommandArgument.ToString());
            }
            if (e.CommandName == "atcProduct")
            {
                if (um.addToCart(e.CommandArgument.ToString(), uid))
                {
                    Repeater2.DataBind();
                    //Response.Redirect("UserHome.aspx");
                }
            }
        }

        protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                String pid = ((Label)e.Item.FindControl("lblSPid") as Label).Text;
                Label lbls = ((Label)e.Item.FindControl("lblInStock") as Label);
                Button btnatc = ((Button)e.Item.FindControl("btnSPatc") as Button);
                Button btnbuy = ((Button)e.Item.FindControl("btnSPBuy") as Button);

                if (um.isInCart(pid, uid))
                {
                    btnatc.Visible = false;
                    btnbuy.Width = Unit.Parse("100%");
                }
                else
                {
                    btnatc.Visible = true;
                }

                if (!um.isInStock(pid))
                {
                    btnatc.Visible = false;
                    btnbuy.Visible = false;
                    lbls.Visible = true;
                }
            }
        }
    }
}