namespace WebApplication.Entity
{
    /// <summary>
    /// Cart items
    /// </summary>
    public class CartItems
    {
        /// <summary>
        /// Product
        /// </summary>
        public Product Product { get; set; }

        /// <summary>
        /// Quantity
        /// </summary>
        public int Quantity { get; set; }

        /// <summary>
        /// Total
        /// </summary>
        public decimal Total { get
            {
                if(this.Product == null) return 0;

                return this.Product.Price * Quantity;
            }
        }
    }
}