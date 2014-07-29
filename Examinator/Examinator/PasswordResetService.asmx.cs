using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Net.Mail;
using System.Data;

namespace Examinator
{
    /// <summary>
    /// Password related services - forgot password and new user registration, which use send email to
    /// notify the user.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PasswordResetService : System.Web.Services.WebService
    {
        /// <summary>
        /// When the 'Forgot Password?' link is clicked on the masterpage, this method is called from the 
        /// javascript function 'forgotPW' (LoginandHome.js).
        /// The 'spForgotPW' procedure in the database is executed and a message is returned depending on whether
        /// the procedure was successful or not.
        /// </summary>
        /// <param name="emailAddress"></param>
        /// <param name="newPassword">Randomly generated in a javascript function</param>
        /// <returns></returns>
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

        /// <summary>
        /// Generates a message for new users and passes the message along with the username and password
        /// to be sent to the user by the sendEmail method.
        /// </summary>
        /// <param name="emailAddress"></param>
        /// <param name="username"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        [WebMethod]
        public string newUserRegs(string emailAddress, string username, string password)
        {
            string message = "Greetings, and Thank you for registering your account at The Examinator. Your Username is: " + 
            username + " and your password is: " + password + ". Please keep your information safe. Live long and prosper, denizen of Planet Earth!";
            string subject = "You Registered at The Examinator.";
            string result = sendEmail(emailAddress, message, subject);
            return result;
        }

        /// <summary>
        /// Sends an email to the specified email address with the specified subject and message.
        /// </summary>
        /// <param name="emailAddress"></param>
        /// <param name="message"></param>
        /// <param name="subject"></param>
        /// <returns></returns>
        private string sendEmail(string emailAddress, string message, string subject)
        {
            string result;
            MailMessage emailPWReset = new MailMessage();
            emailPWReset.From = new MailAddress("examinator.sadpanda@gmail.com");
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
                    Credentials = new System.Net.NetworkCredential("examinator.sadpanda@gmail.com", "sadpanda"),
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
