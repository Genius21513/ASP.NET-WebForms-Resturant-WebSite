using WebApplication.Data.Persistence;

namespace WebApplication.Data
{
    /// <summary>
    /// Web session
    /// </summary>
    public static class Factory 
    {
        public static UserSQl CreateUser ()
        {
            return new UserSQl();
        }

        public static SettingSQl CreateSetting()
        {
            return new SettingSQl();
        }

        public static CustomerSQL CreateCustomer()
        {
            return new CustomerSQL();
        }

        public static ProductSQL CreateProduct()
        {
            return new ProductSQL();
        }

        public static CartSQL CreateCart()
        {
            return new CartSQL();
        }
        public static OrdensSQl CreateOrdens()
        {
            return new OrdensSQl();
        }

        public static DashboardSQl CreateDash()
        {
            return new DashboardSQl();
        }

        public static StatisticsSQl CreateStatistics()
        {
            return new StatisticsSQl();
        }

        public static TablesSQL CreateTables()
        {
            return new TablesSQL();
        }

        public static CategorySQL CreateCategoy()
        {
            return new CategorySQL();
        }
    }
}