using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data;
using System.Data.SqlClient;


namespace appsec
{
    public partial class Login : System.Web.UI.Page
    {
        string MYDBConnectionString =System.Configuration.ConfigurationManager.ConnectionStrings["MYDBConnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void LoginMe(object sender, EventArgs e)
        {
            string pwd = HttpUtility.HtmlEncode(pwdText.Text.ToString().Trim());
            string userid = HttpUtility.HtmlEncode(emailText.Text.ToString().Trim());
            SHA512Managed hashing = new SHA512Managed();
            string dbHash = getDBHash(userid);
            string dbSalt = getDBSalt(userid);
            int attempts = Convert.ToInt32(getAttempts(userid));
            try
            {
                if (dbSalt != null && dbSalt.Length > 0 && dbHash != null && dbHash.Length > 0)
                {
                    string pwdWithSalt = pwd + dbSalt;
                    byte[] hashWithSalt = hashing.ComputeHash(Encoding.UTF8.GetBytes(pwdWithSalt));
                    string userHash = Convert.ToBase64String(hashWithSalt);
                    if (attempts >= 3)
                    {
                        errorMsg.Text = "Your account has been locked out. Please contact a System Administrator for further instructions";
                        return;
                    }
                    else if (userHash.Equals(dbHash))
                    {
                        Session["LoggedIn"] = userid;
                        string guid = Guid.NewGuid().ToString();
                        Session["AuthToken"] = guid;
                        Response.Cookies.Add(new HttpCookie("AuthToken", guid));
                        Response.Redirect("Success.aspx", false);
                    }
                    else if (!userHash.Equals(dbHash) && attempts <3 )
                    {
                        try
                        {
                            using (SqlConnection con = new SqlConnection(MYDBConnectionString))
                            {
                                using (SqlCommand AddAttempts = new SqlCommand("UPDATE Account SET LoginAttempts=@ATTEMPTS WHERE Email=@USERID"))
                                {
                                    using (SqlDataAdapter sda = new SqlDataAdapter())
                                    {
                                        AddAttempts.CommandType = CommandType.Text;
                                        AddAttempts.Parameters.AddWithValue("@USERID", userid);
                                        AddAttempts.Parameters.AddWithValue("@ATTEMPTS", attempts + 1);

                                        AddAttempts.Connection = con;
                                        con.Open();
                                        AddAttempts.ExecuteNonQuery();
                                        con.Close();
                                    }
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(ex.ToString());
                        }
                        errorMsg.Text = "Login has failed. Please try again.";
                        return;
                    }
                    
                } 

            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }


        }
        protected string getAttempts(string userid)
        {
            string h = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select LoginAttempts FROM Account WHERE Email=@USERID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["LoginAttempts"] != null)
                        {
                            if (reader["LoginAttempts"] != DBNull.Value)
                            {
                                h = reader["LoginAttempts"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }
        protected string getDBHash(string userid)
        {
            string h = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select PasswordHash FROM Account WHERE Email=@USERID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {

                    while (reader.Read())
                    {
                        if (reader["PasswordHash"] != null)
                        {
                            if (reader["PasswordHash"] != DBNull.Value)
                            {
                                h = reader["PasswordHash"].ToString();
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return h;
        }
        protected string getDBSalt(string userid)
        {
            string s = null;
            SqlConnection connection = new SqlConnection(MYDBConnectionString);
            string sql = "select PASSWORDSALT FROM ACCOUNT WHERE Email=@USERID";
            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@USERID", userid);
            try
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        if (reader["PASSWORDSALT"] != null)
                        {
                            if (reader["PASSWORDSALT"] != DBNull.Value)
                            {
                                s = reader["PASSWORDSALT"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally { connection.Close(); }
            return s;
        }
    }
}
