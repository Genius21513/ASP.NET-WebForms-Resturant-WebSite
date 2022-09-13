namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Category SQL
    /// </summary>
    public class CategorySQL
    {
        public string List()
        {
            return "SELECT Id, Description FROM [dbo].[Category] WITH (NOLOCK)";
        }
    }
}