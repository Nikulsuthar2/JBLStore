using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.User
{
    public partial class UserMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uid"] != null)
            {
                if (Session["uname"] != null)
                {
                    hlUsername.Text = Session["uname"].ToString();
                }
            }
            else
            {
                Response.Redirect("UserLogin.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["uid"] = null;
            Session["uname"] = null;
            Response.Redirect("UserLogin.aspx");
        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            if(txtSearch.Text != "")
            {
                Response.Redirect("SearchResult.aspx?search=" + txtSearch.Text);
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("UserHome.aspx");
        }
    }
}