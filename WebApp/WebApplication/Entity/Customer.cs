using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// Cusomer
    /// </summary>
    public class Customer
    {
        public int Id { get; set; }        

        public string FirstName {get;set;}

        public string LastName { get; set; }        

        public string Email { get; set; }

        public string PhoneNumber { get; set; }

        public string Address1 { get; set; }

        public string Address2 { get; set; }

        public int Country { get; set; }
        public int State { get; set; }

        public int City { get; set; }
        public string PostalCode { get; set; }

        public Customer()
        {

        }

        public Customer(DataTable dtCustomer)
        {
            if (dtCustomer != null && dtCustomer.Rows != null)
            {
                Id = int.Parse(dtCustomer.Rows[0]["Id"].ToString());
                FirstName = dtCustomer.Rows[0]["FirstName"].ToString();
                LastName = dtCustomer.Rows[0]["LastName"].ToString();
                Email = dtCustomer.Rows[0]["Email"].ToString();
                PhoneNumber = dtCustomer.Rows[0]["PhoneNumber"].ToString();
                Address1 = dtCustomer.Rows[0]["Address1"].ToString();
                Address2 = dtCustomer.Rows[0]["Address2"].ToString();
                Country = int.Parse(dtCustomer.Rows[0]["CountryId"].ToString());
                State = int.Parse(dtCustomer.Rows[0]["StateId"].ToString());
                City = int.Parse(dtCustomer.Rows[0]["CityId"].ToString());
                PostalCode = dtCustomer.Rows[0]["PostalCode"].ToString();              
            }
        }
    }
}