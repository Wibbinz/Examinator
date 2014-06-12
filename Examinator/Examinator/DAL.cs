using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;

namespace DAL
{
    /// <summary>
    /// Class DAL for communicating with the Database.
    /// </summary>
    public class DAL
    {
        string ConnString;
        List<SqlParameter> _parameters;

        public DAL(string connString)
        {
            _parameters = new List<SqlParameter>();
            ConnString = connString;
        }

        /// <summary>
        /// Method for adding parameters to a list of SqlParameters.
        /// </summary>
        /// <param name="paramName">The variable name of the parameter</param>
        /// <param name="paramValue">The value of the the parameter</param>
        public void AddParam(string paramName, object paramValue)
        {
            _parameters.Add(new SqlParameter(paramName, paramValue));
        }


        /// <summary>
        /// Method to run a stored procedure in the database.
        /// </summary>
        /// <param name="procName">Name of the stored procedure to be run.</param>
        /// <returns>Dataset returned by the procedure run.</returns>
        public DataSet ExecuteProcedure(string procName)
        {
            DataSet dsResult = new DataSet();
            SqlConnection conn = new SqlConnection(ConnString);
            SqlDataAdapter da = new SqlDataAdapter(procName, conn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter param in _parameters)
            {
                da.SelectCommand.Parameters.Add(param);
            }
            conn.Open();
            da.Fill(dsResult);
            conn.Close();
            return dsResult;
        }


        /// <summary>
        /// Method to execute a select command
        /// </summary>
        /// <param name="select">Select String</param>
        /// <returns>Dataset resulting from the Select String</returns>
        public DataSet ExecuteCommand(string select)
        {
            DataSet dsResult = new DataSet();
            SqlConnection conn = new SqlConnection(ConnString);
            SqlCommand cmd = new SqlCommand(select, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            conn.Open();
            da.Fill(dsResult);
            conn.Close();
            return dsResult;
        }


        /// <summary>
        /// Method to run a select statement to return a single value.
        /// </summary>
        /// <param name="selectStatement">The select statement to be run.</param>
        /// <returns>Since this is used primarily for prices, id numbers and other numbers,
        /// the object returned is of type double.</returns>
        public double ExecuteScalar(string selectStatement)
        {
            double value = 0; 
            object temp = new object();
            SqlConnection conn = new SqlConnection(ConnString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = new SqlCommand(selectStatement, conn);
            conn.Open();
            temp = cmd.ExecuteScalar();
            conn.Close();
            if (DBNull.Value.Equals(temp) || temp == null)
                value = 0;
            else value = Convert.ToDouble(temp);
            return value;
        }       


        /// <summary>
        /// Method to retrieve a view created in the database. Used primarily in ViewReports.aspx.
        /// </summary>
        /// <param name="viewName">Name of the view to be retrieved.</param>
        /// <returns>Dataset for use in gridviews.</returns>
        public DataSet RetrieveView(string viewName)
        {
            DataSet dsResult = new DataSet();
            SqlConnection conn = new SqlConnection(ConnString);
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT * FROM " + viewName, conn);
            da.Fill(dsResult);
            conn.Close();
            return dsResult;
        }        
    }
}
