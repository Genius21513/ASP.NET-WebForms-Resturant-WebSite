using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// Category
    /// </summary>
    public class Category
    {
        /// <summary>
        /// Id
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// Description
        /// </summary>
        public string Description { get; set; }               

        /// <summary>
        /// UrlImg
        /// </summary>
        public string UrlImg { get; set; }        

        /// <summary>
        /// Category
        /// </summary>
        public Category()
        {

        }

        /// <summary>
        /// Category
        /// </summary>
        /// <param name="dtCategory"></param>
        public Category(DataTable dtCategory)
        {
            
        }
    }
}