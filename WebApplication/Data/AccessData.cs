using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace WebApplication.Data
{
    /// <summary>
    /// Web session
    /// </summary>
    public class AccessData : IDisposable
    {
        /// <summary>
        /// Context
        /// </summary>
        private readonly ContextBase context;

        private bool contextBaseOk;

        private bool activeConnection;

        private bool activeContt;

        public AccessData(ContextBase contextBase)
        {
            context = contextBase;
        }

        public AccessData()
        {
            context = new ContextBase();
        }

        public AccessData(ContextBase context, bool createTrn)
        {
            Constructor(context, createTrn);
        }

        private void Constructor(ContextBase context, bool createTrn)
        {
            if (context != null)
            {
                if (string.IsNullOrEmpty(context.sConnectionString))
                {
                    context.sConnectionString = ContextBase.GetConnectionString();
                }

                context.CreateTrn = createTrn;

                context.conn = new SqlConnection(context.sConnectionString);

                context.conn.Open();

                activeConnection = true;

                if (context.CreateTrn && context.trn == null)
                {
                    context.trn = context.conn.BeginTransaction(IsolationLevel.ReadCommitted);
                    activeContt = true;
                }

                try
                {
                    string sSql = $@"DECLARE @binvar as VARBINARY(128);
                                     SET @binvar = CONVERT(VARBINARY(128),'{context.User}');
                                     SET CONTEXT_INFO @binvar;";

                    DoSql(sSql);
                }
                catch
                {
                }
            }
        }

        public List<T> GetList<T>(string sSql)
        {
            using (DataTable oDt = this.GetDT(sSql))
            {
                return PrrencherTodosDataTable<T>(oDt);
            }
        }

        private List<T> PrrencherTodosDataTable<T>(DataTable oDt)
        {
            List<T> oLista = new List<T>();
            T obj = Activator.CreateInstance<T>();

            foreach (DataRow oDr in oDt.Rows)
            {
                obj = this.PreencheClasseCW<T>(oDr);
                oLista.Add(obj);
            }

            return oLista;
        }

        public T PreencheClasseCW<T>(DataRow objDR)
        {

            return default(T);
            //DataColumnCollection objDC = objDR.Table.Columns;

            //T obj = Activator.CreateInstance<T>();
            //Type cwClassType = obj.GetType();
            //System.Reflection.PropertyInfo aProperty = null;
            //if (cwClassType.IsValueType && !(objDR[0].GetType() == typeof(System.DBNull)))
            //{
            //    obj = (T)Convert.ChangeType(objDR[0], cwClassType);
            //}
            //else
            //{
            //    foreach (DataColumn oDt in objDC)
            //    {
            //        aProperty = cwClassType.GetProperty(oDt.ColumnName, BindingFlags.IgnoreCase | BindingFlags.Public | BindingFlags.Instance);

            //        if (aProperty != null)
            //        {
            //            CampoAttribute oCampoAttr = ObterAtributoCampo(aProperty);

            //            if (!(objDR[oDt.ColumnName].GetType() == typeof(System.DBNull)))
            //            {
            //                if (aProperty.CanWrite)
            //                {
            //                    var sValue = objDR[oDt.ColumnName];

            //                    if (oCampoAttr != null && oCampoAttr.bFlResource)
            //                    {
            //                        sValue = this.GetResource(objDR[oDt.ColumnName].ToString());
            //                    }

            //                    if (Nullable.GetUnderlyingType(aProperty.PropertyType) != null)
            //                        sValue = Convert.ChangeType(sValue, Nullable.GetUnderlyingType(aProperty.PropertyType));
            //                    else
            //                        sValue = Convert.ChangeType(sValue, aProperty.PropertyType);

            //                    if (aProperty.PropertyType == typeof(DateTime) && oCampoAttr != null && !oCampoAttr.bFlIgnorarFuso && CWBaseGDA.nCdFusoHorario != defaultOpt.intOpt)
            //                    {
            //                        sValue = GetTimeZone(CWBaseGDA, (DateTime)sValue, TimeZoneDirection.SystemToUser);
            //                    }

            //                    aProperty.SetValue(obj, sValue, null);
            //                }
            //            }
            //        }
            //    }
            //}

            //return ((T)obj);
        }

        private void Connect()
        {
            bool connection = false;

            if (string.IsNullOrEmpty(context.sConnectionString))
            {
                connection = true;
                context.sConnectionString = ContextBase.GetConnectionString();
            }            

            context.conn = new SqlConnection(context.sConnectionString);

            context.conn.Open();

            activeConnection = true;

            if (context.CreateTrn && context.trn == null)
            {
                context.trn = context.conn.BeginTransaction(IsolationLevel.ReadCommitted);
                activeContt = true;
            }

            try
            {
                if (connection)
                {
                    string sSql = $@"DECLARE @binvar as VARBINARY(128);
                                         SET @binvar = CONVERT(VARBINARY(128),'{context.User}');
                                         SET CONTEXT_INFO @binvar;";

                    DoSql(sSql);
                }
            }
            catch
            {
            }
        }

        public T GetValue<T>(string sql)
        {
            if (string.IsNullOrEmpty(sql)) throw new ArgumentNullException("sql");

            T result = default(T);
            Type type = result.GetType();

            if (type.IsValueType)
            {
                try
                {
                    using (IDbCommand cmd = this.GetCommand(sql))
                    {
                        object value = cmd.ExecuteScalar();
                        if (value != DBNull.Value) result = (T)Convert.ChangeType(value, typeof(T));
                    }
                }
                catch (Exception e)
                {
                    throw; //new ExceptionSql(e, sql);
                }
            }
            else
            {
                /// new NotSupportedException(string.Format(Erro.ExTipoNaoSuportado, type.Name, "GetValue<T>()"));
            }

            return result;
        }

        public int DoSql(string sql)
        {
            IDbCommand command = GetCommand(sql);
            int result = command.ExecuteNonQuery();

            return result;
        }

        public DataSet GetDataSet(string sSql)
        {
            return GetDS(sSql, null, null);
        }

        private DataSet GetDS(string sSql, string sSrcTable, DataSet ds)
        {
            return (DataSet)GetData(sSql, sSrcTable, ds, null);
        }

        public DataTable GetDT(string sSql)
        {
            using (DataTable dataTable = new DataTable())
            {
                dataTable.RowChanged += Row_Changed;
                DataTable result = (DataTable)GetData(sSql, null, null, dataTable);
                dataTable.RowChanged -= Row_Changed;
                //lstColumn = null;
                return result;
            }
        }

        private object GetData(string sSql, string sSrcTable, DataSet ds, DataTable dt)
        {            
            DbDataAdapter dbDataAdapter = null;

            try
            {
                IDbCommand command = GetCommand(sSql);
                
                dbDataAdapter = new SqlDataAdapter((SqlCommand)command);
                  
                if (ds == null && dt == null)
                {
                    ds = new DataSet("ROOT");
                }

                if (sSrcTable == null)
                {
                    sSrcTable = "Table";
                }

                if (ds != null)
                {
                    DataTable dataTable = new DataTable(sSrcTable);
                    dataTable.RowChanged += Row_Changed;
                    ds.Tables.Add(dataTable);
                    dbDataAdapter.Fill(ds, sSrcTable);
                    dataTable.RowChanged -= Row_Changed;                    
                }
                else if (dt != null)
                {
                    dbDataAdapter.Fill(dt);
                }                

                dbDataAdapter.Dispose();

                if (ds != null)
                {
                    return ds;
                }

                return dt;
            }
            catch (Exception e)
            {
                dbDataAdapter?.Dispose();
                throw new Exception(e.Message);
            }
        }


        private void Row_Changed(object sender, DataRowChangeEventArgs e)
        {
            //if (e.Action != DataRowAction.Add)
            //{
            //    return;
            //}

            //if (lstColumn == null)
            //{
            //    lstColumn = new List<string>();
            //    foreach (DataColumn column in e.Row.Table.Columns)
            //    {
            //        if (column.DataType == typeof(DateTime))
            //        {
            //            lstColumn.Add(column.ColumnName);
            //        }
            //    }
            //}

            //if (lstColumn == null)
            //{
            //    return;
            //}

            //foreach (string item in lstColumn)
            //{
            //    if (CWBaseGDA.nCdFusoHorario != defaultOpt.intOpt && e.Row[item].ToString().Length > 0 && e.Row[item] != DBNull.Value && Convert.ToDateTime(e.Row[item]) != defaultOpt.dtOpt && Convert.ToDateTime(e.Row[item]) != defaultOpt.dtNulo)
            //    {
            //        e.Row[item] = GetTimeZone(CWBaseGDA, Convert.ToDateTime(e.Row[item]), TimeZoneDirection.SystemToUser);
            //    }
            //}
        }

        private IDbCommand GetCommand(string sSql)
        {            
            Connect();                                  

            IDbCommand dbCommand;

            if (context.trn != null)
            {
                dbCommand = new SqlCommand(sSql, (SqlConnection)context.conn, (SqlTransaction)context.trn);                               
            }
            else
            {
                dbCommand = new SqlCommand(sSql, (SqlConnection)context.conn);                       
            }            

            dbCommand.CommandTimeout = context.conn.ConnectionTimeout;

            return dbCommand;
        }

        public void SetComplete()
        {
            contextBaseOk = true;
            context.bTrnCtxOk = true;
        }

        public void SetAbort()
        {
            contextBaseOk = false;
            context.bTrnCtxOk = false;
        }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
            if (!contextBaseOk)
            {
                context.bTrnCtxOk = false;
            }

            if (activeContt && context.trn != null)
            {
                if (context.bTrnCtxOk)
                {
                    context.trn.Commit();
                }
                else
                {
                    context.trn.Rollback();
                }

                context.trn = null;
            }

            FreeResources();
        }

        ~AccessData()
        {
            FreeResources();
        }

        private void FreeResources()
        {
            if (activeConnection)
            {
                try
                {
                    context.conn.Close();
                }
                catch
                {
                }

                context.conn = null;
                activeConnection = false;
            }
        }
    }
}