using System.Configuration;
using System;
using System.Data;
using System.IO;

namespace WebApplication.Data
{
    /// <summary>
    /// Web session
    /// </summary>
    public class ContextBase
    {
        internal IDbConnection conn;

        internal IDbTransaction trn;

        internal bool bTrnCtxOk = true;

        public bool CreateTrn { get; set; }

        public string sConnectionString;

        private static Configuration configuration = null;

        private static object syncObjConfig = new object();

        public string User { get; set; }

        public ContextBase(string sConnectionString)
        {
            this.sConnectionString = sConnectionString;
        }

        public ContextBase()
        {

        }

        public ContextBase CloneWithNewContt()
        {
            ContextBase ContextBase = new ContextBase();
            return ContextBase;
        }

        public static string GetConnectionString(string sConnectionString = "")
        {
            if(string.IsNullOrEmpty(sConnectionString)) sConnectionString = Const.Default;

            ConnectionStringSettings connectionStringSettings = ConfigurationManager.ConnectionStrings[sConnectionString];
            if (connectionStringSettings == null)
            {
                LoadConfig();

                if (configuration != null)
                {
                    connectionStringSettings = configuration.ConnectionStrings.ConnectionStrings[sConnectionString];
                }
            }

            if (connectionStringSettings == null)
            {
                throw new Exception("");
            }

            return connectionStringSettings.ConnectionString;
        }


        private static void LoadConfig()
        {
            lock (syncObjConfig)
            {
                if (configuration == null)
                {
                    string directoryName = Path.GetDirectoryName(typeof(ContextBase).Assembly.Location);
                    directoryName = Path.GetDirectoryName(directoryName) + "\\web";
                    if (File.Exists(directoryName + ".config"))
                    {
                        configuration = ConfigurationManager.OpenExeConfiguration(directoryName);
                    }
                }
            }
        }
    }
}