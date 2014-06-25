﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Net.Mail;
using System.Data;

namespace Examinator
{
    /// <summary>
    /// Summary description for PasswordResetService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class PasswordResetService : System.Web.Services.WebService
    {

        [WebMethod]
        public string forgotPassword(string emailAddress, string newPassword)
        {
            string result;
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog=dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserEmail", emailAddress);
            dal.AddParam("@UserPass", newPassword);
            ds = dal.ExecuteProcedure("spForgotPW");
            if (ds.Tables[0].Rows[0]["Message"].ToString() == "Invalid Email")
            {
                return "Your email was not found in the database. Sorry!";
            }
            else
            {
                string message = "Your password has been reset to: " + newPassword + ". Please remember to change and record your password.";
                string subject = "Password reset";
                result = sendEmail(emailAddress, message, subject);
                return result;
            }
        }

        [WebMethod]
        public string newUserRegs(string emailAddress, string username, string password)
        {
            string message = "Greetings, and Thank you for registering your account at The Examinator. Your Username is: " + 
            username + " and your password is: " + password + ". Please keep your information safe. Live long and prosper, denizen of Planet Earth!";
            string subject = "You Registered at The Examinator.";
            string result = sendEmail(emailAddress, message, subject);
            return result;
        }

        private string sendEmail(string emailAddress, string message, string subject)
        {
            string result;
            MailMessage emailPWReset = new MailMessage();
            emailPWReset.From = new MailAddress("gwcw2014@gmail.com");
            emailPWReset.To.Add(new MailAddress(emailAddress));
            emailPWReset.Subject = subject;
            emailPWReset.Body = message;
            try
            {
                SmtpClient client = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    Credentials = new System.Net.NetworkCredential("gwcw2014@gmail.com", "pandap4nd4"),
                    DeliveryMethod = SmtpDeliveryMethod.Network
                };
                client.Send(emailPWReset);
                result = "Success! You should be receiving an email shortly.";
            }
            catch (Exception exc)
            {
                result = "fail";
                throw exc;
            }
            return result;
        }
    }
}
