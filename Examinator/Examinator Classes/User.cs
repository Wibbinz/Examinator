using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace Examinator_Classes
{
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

        public int VerifyUser(string name, string pw)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", name);
            dal.AddParam("@UserPass", pw);
            ds = dal.ExecuteProcedure("spVerifyUsers");
            return Convert.ToInt16(ds.Tables[0].Rows[0]["UserLvl"]);
        }

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
