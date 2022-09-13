namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class SettingSQl
    {       
        public string Get()
        {
            string sql = @"SELECT 
                                [Id]
                               ,[UserId]
                               ,[DisplayCategoryCards]
                               ,[EnableSounds]
                               ,[PageWidth]
                               ,[PageHeight]
                               ,[PageMargin]
                           FROM [Web_App_QA].[dbo].[Settings]";
            return sql;
        }

        public string Get(string userName)
        {
            string sql = $@"SELECT S.[Id]
      ,S.[UserId]
      ,S.[DisplayCategoryCards]
      ,S.[EnableSounds]
      ,S.[PageWidth]
      ,S.[PageHeight]
      ,S.[PageMargin]
      ,U.FirstName
      ,U.LastName
      ,U.Email
  FROM [dbo].[Settings] S WITH (NOLOCK)
  JOIN [dbo].[User] U WITH (NOLOCK) ON S.[UserId] = U.ID AND U.UserName = '{userName}'";
            return sql;
        }
    }
}