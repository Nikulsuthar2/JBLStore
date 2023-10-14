using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JBLStore.Admin
{
    public partial class SalesReport : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                displayData();
            }
        }

        protected void ddlYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayData();
        }

        protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            displayData();
        }

        void displayData()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd;
                if(rblReporttype.SelectedIndex == 0)
                {
                    if (!(ddlYear.SelectedIndex <= 0))
                    {
                        if (!(ddlMonth.SelectedIndex <= 0))
                        {
                            cmd = new SqlCommand("SELECT a.email, b.name, c.qty, c.amt, d.datetime FROM product_dtl AS b INNER JOIN user_dtl AS a INNER JOIN order_dtl AS d INNER JOIN orderline AS c ON d.oid = c.oid ON a.uid = d.uid ON b.pid = c.pid WHERE(d.status = 'Completed') AND (YEAR(d.datetime) = @year) AND (MONTH(d.datetime) = @month) ORDER BY d.datetime DESC", con);
                            cmd.Parameters.AddWithValue("@year", ddlYear.SelectedValue);
                            cmd.Parameters.AddWithValue("@month", ddlMonth.SelectedIndex);
                        }
                        else
                        {
                            cmd = new SqlCommand("SELECT a.email, b.name, c.qty, c.amt, d.datetime FROM product_dtl AS b INNER JOIN user_dtl AS a INNER JOIN order_dtl AS d INNER JOIN orderline AS c ON d.oid = c.oid ON a.uid = d.uid ON b.pid = c.pid WHERE(d.status = 'Completed') AND (YEAR(d.datetime) = @year) ORDER BY d.datetime DESC", con);
                            cmd.Parameters.AddWithValue("@year", ddlYear.SelectedValue);
                        }
                    }
                    else
                    {
                        cmd = new SqlCommand("SELECT a.email, b.name, c.qty, c.amt, d.datetime FROM product_dtl AS b INNER JOIN user_dtl AS a INNER JOIN order_dtl AS d INNER JOIN orderline AS c ON d.oid = c.oid ON a.uid = d.uid ON b.pid = c.pid WHERE(d.status = 'Completed') ORDER BY d.datetime DESC", con);
                    }

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    sda.Fill(ds);

                    Repeater1.DataSource = ds;
                    Repeater1.DataBind();
                }
                if (rblReporttype.SelectedIndex == 1)
                {
                    if (!(ddlYear.SelectedIndex <= 0))
                    {
                        if (!(ddlMonth.SelectedIndex <= 0))
                        {
                            cmd = new SqlCommand("SELECT a.name, a.modelid, SUM(b.qty) AS totsold, SUM(b.amt) AS totearn, MAX(c.datetime) AS maxdate FROM product_dtl AS a INNER JOIN orderline AS b INNER JOIN order_dtl AS c ON b.oid = c.oid ON a.pid = b.pid WHERE (c.status = 'Completed') AND(YEAR(c.datetime) = @year) AND(MONTH(c.datetime) = @month) GROUP BY a.name, a.modelid ORDER BY maxdate DESC", con);
                            cmd.Parameters.AddWithValue("@year", ddlYear.SelectedValue);
                            cmd.Parameters.AddWithValue("@month", ddlMonth.SelectedIndex);
                        }
                        else
                        {
                            cmd = new SqlCommand("SELECT a.name, a.modelid, SUM(b.qty) AS totsold, SUM(b.amt) AS totearn, MAX(c.datetime) AS maxdate FROM product_dtl AS a INNER JOIN orderline AS b INNER JOIN order_dtl AS c ON b.oid = c.oid ON a.pid = b.pid WHERE (c.status = 'Completed') AND (YEAR(c.datetime) = @year) GROUP BY a.name, a.modelid ORDER BY maxdate DESC", con);
                            cmd.Parameters.AddWithValue("@year", ddlYear.SelectedValue);
                        }
                    }
                    else
                    {
                        cmd = new SqlCommand("SELECT a.name, a.modelid, SUM(b.qty) AS totsold, SUM(b.amt) AS totearn, MAX(c.datetime) AS maxdate FROM product_dtl AS a INNER JOIN orderline AS b INNER JOIN order_dtl AS c ON b.oid = c.oid ON a.pid = b.pid WHERE (c.status = 'Completed') GROUP BY a.name, a.modelid ORDER BY maxdate DESC", con);
                    }

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();

                    sda.Fill(ds);

                    Repeater2.DataSource = ds;
                    Repeater2.DataBind();
                }
            }
        }

        protected void rblReporttype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(rblReporttype.SelectedIndex == 0)
            {
                displayData();
                Repeater1.Visible = true;
                Repeater2.Visible = false;
            }
            else if (rblReporttype.SelectedIndex == 1)
            {
                displayData();
                Repeater1.Visible = false;
                Repeater2.Visible = true;
            }
        }
    }
}