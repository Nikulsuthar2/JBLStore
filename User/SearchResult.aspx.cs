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
    public partial class SearchResult : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if(Request.QueryString["search"] != null)
                {
                    lblHeader.Text = "Search - '"+ Request.QueryString["search"].ToString() + "'";
                    displayData(0);
                }
                if (Request.QueryString["speaker"] != null)
                {
                    lblHeader.Text = "Speaker";
                    displayData(1);
                }
                if (Request.QueryString["headset"] != null)
                {
                    lblHeader.Text = "Headset";
                    displayData(2);
                }
            }
        }

        void displayData(int type)
        {
            string query = "";
            if (type == 0)
            {
                query = "select * from product_dtl where (modelid like '%"+ Request.QueryString["search"].ToString() + "%' or name like '%" + Request.QueryString["search"].ToString()+"%')";
            }
            else if(type == 1 || type == 2)
            {
                query = "select  * from product_dtl where type = '"+lblHeader.Text+"'";
            }
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                Repeater1.DataSource = ds;
                Repeater1.DataBind();
            }
        }
    }
}