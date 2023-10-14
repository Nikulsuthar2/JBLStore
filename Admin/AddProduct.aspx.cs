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
    public partial class AddProduct : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Request.QueryString["updtid"] != null)
            {
                btnAdd.Visible = false;
                btnUpdate.Visible = true;
                txtQty.Visible = false;
                lblQty.Visible = false;
                lblHeader.Text = "Update Product";
                rfvImage.Enabled = false;
                rfvQty.Enabled = false;
                if (!IsPostBack)
                {
                    bindData(Request.QueryString["updtid"].ToString());
                }
            }
            else
            {
                btnAdd.Visible = true;
                txtQty.Visible = true;
                lblQty.Visible = true;
                lblHeader.Text = "Add Product";
                rfvImage.Enabled = true;
                rfvQty.Enabled = true;
                btnUpdate.Visible = false;
            }
        }

        void bindData(string modelid)
        {
            using(SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from product_dtl where modelid = @modelid", con);
                cmd.Parameters.AddWithValue("@modelid",modelid);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);
                con.Close();

                if(ds.Tables[0].Rows.Count > 0)
                {
                    ddlType.SelectedValue = ds.Tables[0].Rows[0]["Type"].ToString();
                    if (ddlType.SelectedValue == "Speaker")
                    {
                        lblSubType.Text = "Speaker Type : ";
                        ddlSubType.Items.Clear();
                        ddlSubType.Items.Add("Soundbar Speaker");
                        ddlSubType.Items.Add("Bluetooth Speaker");
                    }
                    else if (ddlType.SelectedValue == "Headset")
                    {
                        lblSubType.Text = "Headphone Type : ";
                        ddlSubType.Items.Clear();
                        ddlSubType.Items.Add("Earbud");
                        ddlSubType.Items.Add("In the ear");
                        ddlSubType.Items.Add("On the ear");
                        ddlSubType.Items.Add("Behind the neck");
                    }
                    else
                    {
                        ddlSubType.Items.Clear();
                    }
                    txtModelid.Text = ds.Tables[0].Rows[0]["modelid"].ToString();
                    txtModelid.Enabled = false;
                    txtName.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    txtPrice.Text = ds.Tables[0].Rows[0]["price"].ToString();
                    txtDiscount.Text = ds.Tables[0].Rows[0]["discount"].ToString();
                    txtDescription.Text = ds.Tables[0].Rows[0]["description"].ToString();
                    ddlColor.SelectedValue = ds.Tables[0].Rows[0]["color"].ToString();
                    ddlConnectivity.SelectedValue = ds.Tables[0].Rows[0]["connectivity"].ToString();
                    ddlSubType.SelectedValue = ds.Tables[0].Rows[0]["subtype"].ToString();
                    cbMic.Checked = ds.Tables[0].Rows[0]["mic"].ToString() == "Yes" ? true : false;
                    cbBass.Checked = ds.Tables[0].Rows[0]["deepbass"].ToString() == "Yes" ? true : false;
                    cbWaterResist.Checked = ds.Tables[0].Rows[0]["waterproof"].ToString() == "Yes" ? true : false;
                    txtFeature.Text = ds.Tables[0].Rows[0]["features"].ToString();
                }
            }
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlType.SelectedValue == "Speaker")
            {
                lblSubType.Text = "Speaker Type : ";
                ddlSubType.Items.Clear();
                ddlSubType.Items.Add("Soundbar Speaker");
                ddlSubType.Items.Add("Bluetooth Speaker");
            }
            else if(ddlType.SelectedValue == "Headset")
            {
                lblSubType.Text = "Headphone Type : ";
                ddlSubType.Items.Clear();
                ddlSubType.Items.Add("Earbud");
                ddlSubType.Items.Add("In the ear");
                ddlSubType.Items.Add("On the ear");
                ddlSubType.Items.Add("Behind the neck");
            }
            else
            {
                ddlSubType.Items.Clear();
            }
        }
        
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                FileUpload1.SaveAs(Server.MapPath("~/Images/Product/" +  FileUpload1.FileName));
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("select modelid from product_dtl where modelid = @modelid",con);
                    cmd.Parameters.AddWithValue("@modelid", txtModelid.Text);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (!dr.HasRows)
                    {
                        dr.Close();
                        cmd = new SqlCommand("insert into product_dtl(modelid,name,price,discount,description,image,type,color,connectivity,mic,subtype,deepbass,waterproof,features) values (@modelid,@name,@price,@dcnt,@desc,@img,@type,@clr,@con,@mic,@stype,@bass,@wproof,@feature)", con);
                        cmd.Parameters.AddWithValue("@modelid", txtModelid.Text);
                        cmd.Parameters.AddWithValue("@name", txtName.Text);
                        cmd.Parameters.AddWithValue("@price", txtPrice.Text);
                        cmd.Parameters.AddWithValue("@dcnt", txtDiscount.Text);
                        cmd.Parameters.AddWithValue("@desc", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@img", "~/Images/Product/" + FileUpload1.FileName);
                        cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
                        cmd.Parameters.AddWithValue("@clr", ddlColor.SelectedValue);
                        cmd.Parameters.AddWithValue("@con", ddlConnectivity.SelectedValue);
                        cmd.Parameters.AddWithValue("@mic", cbMic.Checked ? "Yes" : "No");
                        cmd.Parameters.AddWithValue("@stype", ddlSubType.SelectedValue);
                        cmd.Parameters.AddWithValue("@bass", cbBass.Checked ? "Yes" : "No");
                        cmd.Parameters.AddWithValue("@wproof", cbWaterResist.Checked ? "Yes" : "No");
                        cmd.Parameters.AddWithValue("@feature", txtFeature.Text);

                        int res = cmd.ExecuteNonQuery();

                        if (res > 0)
                        {
                            cmd = new SqlCommand("insert into stock(modelid,qty) values(@modelid,@qty)", con);
                            cmd.Parameters.AddWithValue("@modelid", txtModelid.Text);
                            cmd.Parameters.AddWithValue("@qty", txtQty.Text);

                            int res2 = cmd.ExecuteNonQuery();
                            if(res2 > 0)
                            {
                                Response.Redirect("Product.aspx");
                            }

                        }
                        con.Close();
                    }
                    else
                    {

                    }
                    
                }
            }
            
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd;
                if (FileUpload1.HasFile)
                {
                    FileUpload1.SaveAs(Server.MapPath("~/Images/Product/" + FileUpload1.FileName));
                    cmd = new SqlCommand("update product_dtl set name = @name, price = @price, discount = @dcnt, description = @desc, image = @img, type = @type, color = @clr, connectivity = @con, mic = @mic, subtype = @stype, deepbass = @bass, waterproof = @wproof, features = @feature where modelid = @modelid", con);
                    cmd.Parameters.AddWithValue("@img", "~/Images/Product/" + FileUpload1.FileName);
                }
                else
                {
                    cmd = new SqlCommand("update product_dtl set name = @name, price = @price, discount = @dcnt, description = @desc, type = @type, color = @clr, connectivity = @con, mic = @mic, subtype = @stype, deepbass = @bass, waterproof = @wproof, features = @feature where modelid = @modelid", con);
                }
                cmd.Parameters.AddWithValue("@name", txtName.Text);
                cmd.Parameters.AddWithValue("@price", txtPrice.Text);
                cmd.Parameters.AddWithValue("@dcnt", txtDiscount.Text);
                cmd.Parameters.AddWithValue("@desc", txtDescription.Text);
                cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
                cmd.Parameters.AddWithValue("@clr", ddlColor.SelectedValue);
                cmd.Parameters.AddWithValue("@con", ddlConnectivity.SelectedValue);
                cmd.Parameters.AddWithValue("@mic", cbMic.Checked ? "Yes" : "No");
                cmd.Parameters.AddWithValue("@stype", ddlSubType.SelectedValue);
                cmd.Parameters.AddWithValue("@bass", cbBass.Checked ? "Yes" : "No");
                cmd.Parameters.AddWithValue("@wproof", cbWaterResist.Checked ? "Yes" : "No");
                cmd.Parameters.AddWithValue("@feature", txtFeature.Text);
                cmd.Parameters.AddWithValue("@modelid", txtModelid.Text);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    Response.Write("<script>alert('Updated');location.href='Product.aspx';</script>");
                }
                else
                {
                    Response.Write("<script>alert('not worked')</script>");
                }
            }
        }

        protected void btnBackProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("Product.aspx");
        }
    }
}