using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// User
    /// </summary>
    public class User
    {
        /// <summary>
        /// Id
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// User Name
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// First Name
        /// </summary>
        public string FirstName {get;set;}

        /// <summary>
        /// Last Name
        /// </summary>
        public string LastName { get; set; }

        /// <summary>
        /// Has Pw
        /// </summary>
        public string HasPw { get; set; }

        /// <summary>
        /// Email
        /// </summary>
        public string Email { get; set; }

        public Setting Setting { get; set; }

        /// <summary>
        /// Construtor
        /// </summary>
        public User()
        {

        }

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="dtUser"></param>
        public User(DataTable dtUser)
        {
            if (dtUser != null && dtUser.Rows != null)
            {
                Id = int.Parse(dtUser.Rows[0]["Id"].ToString());
                FirstName = dtUser.Rows[0]["FirstName"].ToString();
                LastName = dtUser.Rows[0]["LastName"].ToString();
                Email = dtUser.Rows[0]["Email"].ToString();
            }
        }
    }
}
