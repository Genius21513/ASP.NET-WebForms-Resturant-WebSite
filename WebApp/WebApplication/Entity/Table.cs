using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// Table
    /// </summary>
    public class Table
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
        /// Active
        /// </summary>
        public bool Active { get; set; }

        /// <summary>
        /// Seats
        /// </summary>
        public int Seats { get; set; }

        public int CustomerId { get; set; } 

        public string HoldOrder { get; set; }
    
        /// <summary>
        /// Construtor
        /// </summary>
        public Table()
        {

        }

        /// <summary>
        /// Construtor
        /// </summary>
        /// <param name="dtTable"></param>
        public Table(DataTable dtTable)
        {
            if (dtTable != null && dtTable.Rows != null)
            {
                Id = int.Parse(dtTable.Rows[0]["Id"].ToString());
                Description = dtTable.Rows[0]["Description"].ToString();
                Active = (bool)dtTable.Rows[0]["Active"];
                Seats = int.Parse(dtTable.Rows[0]["Seats"].ToString());
            }
        }
    }
}
