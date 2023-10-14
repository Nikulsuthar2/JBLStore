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
    public partial class ProductDetails : System.Web.UI.Page
    {
        UserMethod um = new UserMethod();
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["uid"] != null)
            {
                if (Request.QueryString["pid"] != null)
                {
                    if (!IsPostBack)
                    {
                        bindData(Request.QueryString["pid"].ToString());
                    }
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
            
        }

        void bindData(string pid)
        {
            using(SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from product_dtl a, stock b where a.modelid = b.modelid and a.pid = @pid", con);
                cmd.Parameters.AddWithValue("@pid", pid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);
;               con.Close();
                if(ds.Tables[0].Rows.Count > 0)
                {
                    imgProduct.ImageUrl = ds.Tables[0].Rows[0]["image"].ToString();
                    lblName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    lblPrice.Text = "&#8377;" + ds.Tables[0].Rows[0]["price"].ToString();
                    lblDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
                    int dcnt = Int32.Parse(ds.Tables[0].Rows[0]["discount"].ToString());

                    if (dcnt > 0)
                    {
                        lblDcnt.Visible = true;
                        lblDcntPrice.Visible = true;
                        lblDcnt.Text = ds.Tables[0].Rows[0]["discount"].ToString() + "%";
                        lblPrice.Font.Strikeout = true;
                        lblDcntPrice.Text = "&#8377;" + (Double.Parse(ds.Tables[0].Rows[0]["price"].ToString()) - (Double.Parse(ds.Tables[0].Rows[0]["price"].ToString()) * (Double.Parse(ds.Tables[0].Rows[0]["discount"].ToString()) / 100))).ToString();
                    }

                    if (um.isInCart(pid, Session["uid"].ToString()))
                    {
                        btnATC.Visible = false;
                    }

                    if (Int32.Parse(ds.Tables[0].Rows[0]["qty"].ToString()) == 0)
                    {
                        btnATC.Visible = false;
                        btnBuy.Visible = false;
                        lblStock.Visible = true;
                    }

                    lblModelid.Text = ds.Tables[0].Rows[0]["modelid"].ToString();
                    lblType.Text = ds.Tables[0].Rows[0]["type"].ToString();
                    if(lblType.Text == "Speaker")
                    {
                        lblSubTypeTitle.Text = "Speaker Type";
                    }
                    else
                    {
                        lblSubTypeTitle.Text = "Headset Type";
                    }
                    lblColor.Text = ds.Tables[0].Rows[0]["Color"].ToString();
                    lblConnectivity.Text = ds.Tables[0].Rows[0]["connectivity"].ToString();
                    lblMic.Text = ds.Tables[0].Rows[0]["mic"].ToString();
                    lblSubType.Text = ds.Tables[0].Rows[0]["subtype"].ToString();
                    lblBass.Text = ds.Tables[0].Rows[0]["deepbass"].ToString();
                    lblWProof.Text = ds.Tables[0].Rows[0]["waterproof"].ToString();
                    lblFeatures.Text = ds.Tables[0].Rows[0]["features"].ToString();
                }
            }
        }

        protected void btnATC_Click(object sender, EventArgs e)
        {
            if (um.addToCart(Request.QueryString["pid"].ToString(), Session["uid"].ToString()))
            {
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void btnBuy_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx?pid=" + Request.QueryString["pid"].ToString());
        }
    }
}