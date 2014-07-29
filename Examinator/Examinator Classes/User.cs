using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Examinator_Classes
{
    /// <summary>
    /// This class holds all information associated with a User including fields and constructors for
    /// Username, User Password, User Email and bools for whether the user is an administrator, wants their
    /// personal scores to appear on the public scoreboard or wants unapproved questions to be displayed or not.
    /// </summary>
    public class User
    {
        public string _userName;
        public string _userPW;
        public bool _userifAdmin;
        public string _userEmail;
        public bool _prefLeader;
        public bool _prefUnapproved;


        public string UserName { get { return _userName; } set { _userName = value; } }
        public string UserPW { get { return _userPW; } set { _userPW = value; } }
        public bool UserifAdmin { get { return _userifAdmin; } set { _userifAdmin = value; } }
        public string UserEmail { get { return _userEmail; } set { _userEmail = value; } }
        public bool PrefLeader { get { return _prefLeader; } set { _prefLeader = value; } }
        public bool PrefUnapproved { get { return _prefUnapproved; } set { _prefUnapproved = value; } }

        public User() : this("guest", "guest", false, "guest", false, false) { }

        public User(string user, string pw, bool admin, string email, bool leader, bool unapproved)
        {
            _userName = user;
            _userPW = pw;
            _userifAdmin = admin;
            _userEmail = email;
            _prefLeader = leader;
            _prefUnapproved = unapproved;
        }

        /// <summary>
        /// This method is called by the DefaultMaster page, when a user attempts to log in.
        /// It passes the username and password through the 'spVerifyUsers' procedure of the database.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="pw"></param>
        /// <returns>The level of the user, which is -1 if the username or password do not match and a 2 if 
        /// the user is an administrator, or a 1 if the user information is valid but does not have level clearance.</returns>
        public int VerifyUser(string name, string pw)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", name);
            dal.AddParam("@UserPass", pw);
            ds = dal.ExecuteProcedure("spVerifyUsers");
            return Convert.ToInt16(ds.Tables[0].Rows[0]["UserLvl"]);
        }

        /// <summary>
        /// This method is called by the DefaultMaster page when a new user registers their account.
        /// It passes the username, password and email through the 'spAddUsers' procedure of the database.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="pw"></param>
        /// <param name="email"></param>
        /// <returns>If returns a value of 'UserID Exists' of 'User Email Exists' if the username or
        /// email address already exist in the database, otherwise it returns the userid.</returns>
        public string addNewUser(string name, string pw, string email)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", name);
            dal.AddParam("@UserPass", pw);
            dal.AddParam("@UserEmail", email);
            ds = dal.ExecuteProcedure("spAddUsers");
            return ds.Tables[0].Rows[0][0].ToString();
        }

        /// <summary>
        /// This method is called by the DefaultMaster page when a user logs in. It passes the username
        /// through the 'spGetPreferences' procedure of the database to retrieve the settings of that user
        /// that determine whether they wish their scores to be displayed on the public scoreboard or not
        /// as well as whether they want to see unapproved questions or not.
        /// </summary>
        /// <param name="name"></param>
        /// <param name="pw"></param>
        /// <param name="access"></param>
        /// <returns>The variable 'currentUser' of type User is populated with all the information
        /// retrieved and returned.</returns>
        public User GetPreferences(string name, string pw, bool access)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", name);
            ds = dal.ExecuteProcedure("spGetPreferences");
            bool showLeader; bool showUnapproved;
            string email = ds.Tables[0].Rows[0]["UserEmail"].ToString();

            if ((ds.Tables[0].Rows[0]["PrefShowInLeader"] != null) && !DBNull.Value.Equals(ds.Tables[0].Rows[0]["PrefShowInLeader"]))
            {
                showLeader = Convert.ToBoolean(ds.Tables[0].Rows[0]["PrefShowInLeader"]);
            }
            else
            {
                showLeader = false;
            }
            if ((ds.Tables[0].Rows[0]["PrefShowUnapproved"] != null) && !DBNull.Value.Equals(ds.Tables[0].Rows[0]["PrefShowUnapproved"]))
            {
                showUnapproved = Convert.ToBoolean(ds.Tables[0].Rows[0]["PrefShowUnapproved"]);
            }
            else
            {
               showUnapproved = false;
            }

            User currentUser = new User(name, pw, access, email, showLeader, showUnapproved);
            return currentUser;
        }

        /// <summary>
        /// This method is called by the DefaultMaster page when a user changes their preferences.
        /// It passes the user email, password and preferences along with username, depending on whether
        /// there is any change to the username or not through the 'spUpdatePreferences' procedure in the database.
        /// </summary>
        /// <param name="currentUser"></param>
        /// <param name="same"></param>
        /// <returns>Returns a message if the username was different from the initial username, but already exists
        /// in the database, or a 'good to go' message if the preferences were inserted correctly.</returns>
        public string SetPreferences(User currentUser, bool same)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserEmail", currentUser.UserEmail);
            
            if (!same)
            {
                dal.AddParam("@UserName", currentUser.UserName);
            }

            dal.AddParam("@UserPass", currentUser.UserPW);
            dal.AddParam("@PrefShowInLeader", currentUser.PrefLeader);
            dal.AddParam("@PrefShowUnapproved", currentUser.PrefUnapproved);
            ds = dal.ExecuteProcedure("spUpdatePreferences");
            return ds.Tables[0].Rows[0][0].ToString();
        }


    }
}
