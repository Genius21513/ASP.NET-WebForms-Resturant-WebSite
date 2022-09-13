using System;
using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.Caching;

namespace WebApplication.Components
{
    /// <summary>
    /// Web session
    /// </summary>
    public class WebSession
    {
        /// <summary>
        /// Http Context
        /// </summary>
        private HttpContext _httpContext = HttpContext.Current;

        /// <summary>
        /// Application Path
        /// </summary>
        public string Project { get
            {
                return _httpContext.Request.ApplicationPath + "/";
            } 
        }

        public string CultureInfor { get; set; }

        public string Version { get; set; }

        public string SessionId { get; set; }


        public string GetSession(string index)
        {
            if (_httpContext != null) return string.Empty;
            if (_httpContext.Session != null) return string.Empty;

            return _httpContext.Session[index].ToString();
        }

        public int Language { get; set; }

        public int Timezone { get; set; }

        public int UserCurrency { get; set; }

        public string User { get; set; }

        public WebSession()
        {
            AddCulture();
        }

        private void AddCulture()
        {
            if (!string.IsNullOrWhiteSpace(CultureInfor) && 
                (!(Thread.CurrentThread.CurrentCulture.Name.ToUpper() == CultureInfor.ToUpper()) || !(Thread.CurrentThread.CurrentUICulture.Name.ToUpper() == CultureInfor.ToUpper())))
            {
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(CultureInfor);
            }
        }

        public void SetCache(string sCacheName, object objValue, int nCacheHours, CacheItemPriority objCachePriority)
        {
            DateTime dateTime = DateTime.Now.AddHours(nCacheHours);
            dateTime = new DateTime(dateTime.Year, dateTime.Month, dateTime.Day, 0, 0, 0, 1);
            _httpContext.Cache.Add(sCacheName, objValue, null, dateTime, TimeSpan.Zero, objCachePriority, null);
        }
    }
}