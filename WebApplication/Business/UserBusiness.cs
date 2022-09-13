using System;
using System.Data;
using System.Security.Cryptography;
using System.Text;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication.Business
{
    /// <summary>
    /// User Business
    /// </summary>
    public class UserBusiness
    {
        public DataTable List(ContextBase contextBase)
        {
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateUser().List());
            }
        }

        /// <summary>
        /// Authenticate User
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="user">user</param>
        /// <param name="pw">pw</param>
        /// <returns>tru if success</returns>
        public bool AuthenticateUser(ContextBase contextBase, string user, string pw)
        {
            bool matchUser = false;

            DataTable dt = new DataTable();

            using (AccessData accessData = new AccessData(contextBase))
            {
                dt = accessData.GetDT(Factory.CreateUser().GetPw(user));
            }

            if (dt != null && dt.Rows.Count > 0)
            {
                matchUser = dt.Rows[0]["HasPw"].ToString() == GetMD5(pw);
            }

            return matchUser;
        }

        /// <summary>
        /// Get MD5
        /// </summary>
        /// <param name="strPlain"></param>
        /// <returns></returns>
        public string GetMD5(string strPlain)
        {
            UnicodeEncoding UE = new UnicodeEncoding();
            byte[] HashValue, MessageBytes = UE.GetBytes(strPlain);
            MD5 md5 = new MD5CryptoServiceProvider();
            string strHex = "";


            HashValue = md5.ComputeHash(MessageBytes);
            foreach (byte b in HashValue)
            {
                strHex += String.Format("{0:x2}", b);
            }

            return strHex;
        }

        /// <summary>
        /// Display category cards
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <returns>displayCategoryCards</returns>
        public bool DisplayCategoryCards(ContextBase contextBase)
        {
            DataTable dt = new DataTable();

            using (AccessData accessData = new AccessData(contextBase))
            {
                dt = accessData.GetDT(Factory.CreateUser().DisplayCategoryCards(contextBase.User));
            }

            if (dt != null && dt.Rows.Count > 0)
            {
                return (bool)dt.Rows[0]["DisplayCategoryCards"];
            }

            return false;
        }

        public void Update(ContextBase contextBase, Entity.User user, string newPwField)
        {
            if (!string.IsNullOrWhiteSpace(newPwField))
            {
                user.HasPw = GetMD5(newPwField);
            }            

            if (user != null)
            {                
                if (user.Setting != null)
                {                    
                    using (AccessData accessData = new AccessData(contextBase))
                    {
                        accessData.DoSql(Factory.CreateUser().Update(user, newPwField));                        
                    }
                }
            }
        }

        public void Add(ContextBase contextBase, Entity.User user)
        {
            using (AccessData accessData = new AccessData(contextBase))
            {
                user.HasPw = GetMD5(user.HasPw);

                accessData.DoSql(Factory.CreateUser().Add(user));
            }
        }

        /// <summary>
        /// Get by User Id
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="userId">user Id</param>
        /// <returns>User</returns>
        public User GetById(ContextBase contextBase, int userId)
        {
            DataTable dt;

            using (AccessData accessData = new AccessData(contextBase))
            {
                dt = accessData.GetDT(Factory.CreateUser().GetById(userId));
            }

            return new User(dt);
        }
    }
}
