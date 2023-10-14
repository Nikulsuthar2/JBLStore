using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace JBLStore.Modules
{
    public class UserMethod
    {
        string conStr;

        public UserMethod()
        {
            conStr = ConfigurationManager.ConnectionStrings["dbJBL"].ConnectionString;
        }

        public DataRow getUserDetails(string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from user_dtl where uid = @uid", con);
                cmd.Parameters.AddWithValue("@uid", uid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                return ds.Tables[0].Rows[0];
            }
        }

        public DataRow getOrderData(string oid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from order_dtl where oid = @oid", con);
                cmd.Parameters.AddWithValue("@oid", oid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);

                return ds.Tables[0].Rows[0];
            }
        }

        public bool updateOrderStatus(string oid, string status)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update order_dtl set status = @status where oid = @oid", con);
                cmd.Parameters.AddWithValue("@oid", oid);
                cmd.Parameters.AddWithValue("@status", status);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public bool isInCart(string pid, string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from cart where uid = @uid and pid = @pid", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@pid", pid);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    con.Close();
                    return true;
                }
                else
                {
                    con.Close();
                    return false;
                }
            }
        }

        public bool addToCart(string pid, string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from cart where uid = @uid and pid = @pid", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@pid", pid);

                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.HasRows)
                {
                    dr.Close();
                    cmd = new SqlCommand("insert into cart(uid,pid) values(@uid,@pid)", con);
                    cmd.Parameters.AddWithValue("@uid", uid);
                    cmd.Parameters.AddWithValue("@pid", pid);

                    int res = cmd.ExecuteNonQuery();
                    con.Close();

                    if (res > 0)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return true;
                }
            }
        }

        public bool isInStock(string pid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select a.modelid, a.pid, b.qty from product_dtl a, stock b where a.modelid = b.modelid and a.pid = @pid", con);
                cmd.Parameters.AddWithValue("@pid", pid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    if (int.Parse(ds.Tables[0].Rows[0]["qty"].ToString()) == 0)
                    {
                        con.Close();
                        return false;
                    }
                    else if (int.Parse(ds.Tables[0].Rows[0]["qty"].ToString()) > 0)
                    {
                        con.Close();
                        return true;
                    }
                    else
                    {
                        con.Close();
                        return true;
                    }
                }
                else
                {
                    con.Close();
                    return false;
                }
            }
        }

        public bool setQtyOfCartItm(string pid, string qty, string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update cart set qty = @qty where uid = @uid and pid = @pid", con);
                cmd.Parameters.AddWithValue("@qty", qty);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@pid", pid);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public bool removeInCart(string pid, string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("delete from cart where uid = @uid and pid = @pid", con);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@pid", pid);

                int res = cmd.ExecuteNonQuery();

                if (res > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }

        public int getStockByPid(string pid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select b.qty from product_dtl a, stock b where a.modelid = b.modelid and a.pid = @pid", con);
                cmd.Parameters.AddWithValue("@pid", pid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                return Int32.Parse(ds.Tables[0].Rows[0]["qty"].ToString());
            }
        }

        public DataSet getCartPriceDetails(string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select isNull(sum(a.price * b.qty),0) as totprice, isNull(sum((a.price * b.qty) * (cast(a.discount as float) / 100)),0) as totdcnt, isNull(sum((a.price * b.qty) - ((a.price * b.qty) * (cast(a.discount as float) / 100))),0) as totdcntprice from product_dtl a, cart b where a.pid = b.pid and b.uid = @uid", con);
                cmd.Parameters.AddWithValue("@uid", uid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);

                return ds;
            }
        }

        public int totalCartItem(string uid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select * from cart where uid = @uid", con);
                cmd.Parameters.AddWithValue("@uid", uid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                return ds.Tables[0].Rows.Count;
            }
        }

        public bool payCartOrder(string uid, string totalPrice, string totalItem)
        {
            String orderid = uid + DateTime.Now.ToString("yyyyMMddHHmmssfff"); 
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into order_dtl values(@oid,@uid,@totitem,@totprice,@dt,'New')", con);
                cmd.Parameters.AddWithValue("@oid", orderid);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@totitem", totalItem);
                cmd.Parameters.AddWithValue("@totprice", totalPrice);
                cmd.Parameters.AddWithValue("@dt", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));

                int orderres = cmd.ExecuteNonQuery();

                if(orderres > 0)
                {
                    cmd = new SqlCommand("select a.pid, a.modelid, a.price, a.discount, b.qty from product_dtl a, cart b where a.pid = b.pid and uid = @uid", con);
                    cmd.Parameters.AddWithValue("@uid", uid);

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataSet cartData = new DataSet();

                    sda.Fill(cartData);

                    if (cartData.Tables[0].Rows.Count > 0)
                    {
                        int res = 0, i = 0;
                        while (i < cartData.Tables[0].Rows.Count)
                        {
                            double price = Double.Parse(cartData.Tables[0].Rows[i]["price"].ToString());
                            int discount = int.Parse(cartData.Tables[0].Rows[i]["discount"].ToString());
                            int qty = int.Parse(cartData.Tables[0].Rows[i]["qty"].ToString());

                            cmd = new SqlCommand("insert into orderline(oid,pid,qty,amt) values(@oid,@pid,@qty,@amt)", con);
                            cmd.Parameters.AddWithValue("@oid", orderid);
                            cmd.Parameters.AddWithValue("@pid", cartData.Tables[0].Rows[i]["pid"].ToString());
                            cmd.Parameters.AddWithValue("@qty", qty.ToString());
                            Double amt = (price - (price * ((Double)discount / 100))) * qty;
                            cmd.Parameters.AddWithValue("@amt", amt.ToString());

                            res = cmd.ExecuteNonQuery();
                            if(res > 0)
                            {
                                cmd = new SqlCommand("update stock set qty = qty - @qty where modelid = @modelid", con);
                                cmd.Parameters.AddWithValue("@qty", qty.ToString());
                                cmd.Parameters.AddWithValue("@modelid", cartData.Tables[0].Rows[i]["modelid"].ToString());

                                cmd.ExecuteNonQuery();
                            }
                            i++;
                        }

                        if(res > 0)
                        {
                            cmd = new SqlCommand("delete from cart where uid = @uid", con);
                            cmd.Parameters.AddWithValue("@uid", uid);

                            if(cmd.ExecuteNonQuery() > 0)
                            {
                                return true;
                            }
                            else
                            {
                                return false;
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
        }

        public bool paySingleOrder(string pid, string uid, string totalPrice, string totalItem)
        {
            String orderid = uid + DateTime.Now.ToString("yyyyMMddHHmmssfff");
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("insert into order_dtl values(@oid,@uid,@totitem,@totprice,@dt,'New')", con);
                cmd.Parameters.AddWithValue("@oid", orderid);
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@totitem", totalItem);
                cmd.Parameters.AddWithValue("@totprice", totalPrice);
                cmd.Parameters.AddWithValue("@dt", DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss"));

                int orderres = cmd.ExecuteNonQuery();

                if (orderres > 0)
                {
                    cmd = new SqlCommand("insert into orderline(oid,pid,qty,amt) values(@oid,@pid,@qty,@amt)", con);
                    cmd.Parameters.AddWithValue("@oid", orderid);
                    cmd.Parameters.AddWithValue("@pid", pid);
                    cmd.Parameters.AddWithValue("@qty", "1");
                    cmd.Parameters.AddWithValue("@amt", totalPrice);

                    int res = cmd.ExecuteNonQuery();
                    if (res > 0)
                    {
                        cmd = new SqlCommand("select modelid from product_dtl where pid = @pid",con);
                        cmd.Parameters.AddWithValue("@pid", pid);

                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        DataSet modelid = new DataSet();
                        sda.Fill(modelid);

                        cmd = new SqlCommand("update stock set qty = qty - @qty where modelid = @modelid", con);
                        cmd.Parameters.AddWithValue("@qty", "1");
                        cmd.Parameters.AddWithValue("@modelid", modelid.Tables[0].Rows[0][0].ToString());

                        cmd.ExecuteNonQuery();

                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
                else
                {
                    return false;
                }
            }
        }
    
        public DataSet getOrderLine(string oid)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("select a.image, a.name, b.amt, b.qty from product_dtl a, orderline b where a.pid = b.pid and b.oid = @oid", con);
                cmd.Parameters.AddWithValue("@oid", oid);

                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();

                sda.Fill(ds);

                return ds;
            }
        }
    }
}