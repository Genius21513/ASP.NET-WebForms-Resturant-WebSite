using System;
using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// Transaction
    /// </summary>
    public class Transaction
    {
        /// <summary>
        /// Id
        /// </summary>
        public Guid Id { get; set; }

        /// <summary>
        /// Order Id
        /// </summary>
        public Guid OrderId { get; set; }

        /// <summary>
        /// In
        /// </summary>
        public decimal In { get; set; }

        /// <summary>
        /// Out
        /// </summary>
        public decimal Out { get; set; }

        /// <summary>
        /// Method Id
        /// </summary>
        public int MethodId { get; set; }

        /// <summary>
        /// Reference
        /// </summary>
        public string Reference { get; set; }

        /// <summary>
        /// At
        /// </summary>
        public DateTime At { get; set; }
    

        public Transaction()
        {

        }

        public Transaction(DataTable dtTransaction)
        {
            
        }
    }
}