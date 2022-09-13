using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// 
    /// </summary>
    public class Product
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
        /// Price
        /// </summary>
        public decimal Price { get; set; }

        /// <summary>
        /// UrlImg
        /// </summary>
        public string UrlImg { get; set; }

        /// <summary>
        /// CategoryId
        /// </summary>
        public int CategoryId { get; set; }

        /// <summary>
        /// Costrutor
        /// </summary>
        public Product()
        {

        }

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="dtProduct">DataTable</param>
        public Product(DataTable dtProduct)
        {
            
        }

        /// <summary>
        /// Costrutor
        /// </summary>
        /// <param name="dr"></param>
        public Product(DataRow dr)
        {
            Id = int.Parse(dr["Id"].ToString());
            Description = dr["Description"].ToString();
            Price = decimal.Parse(dr["Price"].ToString());
            UrlImg = dr["UrlImg"].ToString();
            CategoryId = int.Parse(dr["CategoryId"].ToString());
        }
    }
}