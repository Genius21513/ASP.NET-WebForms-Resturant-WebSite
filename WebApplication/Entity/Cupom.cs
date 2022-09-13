using System.Data;
using System;

namespace WebApplication.Entity
{
    /// <summary>
    /// Cumpo
    /// </summary>
    public class Cupom
    {
        /// <summary>
        /// Id
        /// </summary>
        public Guid Id { get; set; }
        
        /// <summary>
        /// Code
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// Validade
        /// </summary>
        public DateTime Validity { get; set; }

        /// <summary>
        /// Value Max
        /// </summary>
        public decimal ValueMax { get; set; }

        /// <summary>
        /// Percentage
        /// </summary>
        public decimal Percentage { get;set; }

        /// <summary>
        /// 
        /// </summary>
        public Cupom()
        {

        }

        /// <summary>
        /// cumpo by dataTable
        /// </summary>
        /// <param name="dtCupom"></param>
        public Cupom(DataTable dtCupom)
        {
            if (dtCupom != null && dtCupom.Rows.Count > 0)
            {
                DataRow dr = dtCupom.Rows[0];

                Id = Guid.Parse(dr["Id"].ToString());
                Code = dr["Code"].ToString();
                Validity = DateTime.Parse(dr["Validity"].ToString());
                ValueMax = decimal.Parse(dr["ValueMax"].ToString());
                Percentage = decimal.Parse(dr["Percentage"].ToString());
            }
        }        
    }
}