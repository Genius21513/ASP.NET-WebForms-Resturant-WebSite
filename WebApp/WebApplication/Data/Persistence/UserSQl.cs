using System;
using WebApplication.Entity;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class UserSQl
    {
        public string GetPw(string user)
        {
            string sql = $"Select HasPw from [dbo].[User] with (nolock) where [UserName]= '{user}'";

            return sql;
        }

        public string DisplayCategoryCards(string user)
        {
            return $"select DisplayCategoryCards from Settings with (nolock) where  UserId in (select id from [user] where UserName = '{user}')";
        }

        public string Update(Entity.User user, string newPwField)
        {
            return $@"UPDATE [dbo].[User]
                       SET [UserName] = {user.UserName}
                          {(string.IsNullOrEmpty(newPwField) ? $",[HasPw] = '{user.HasPw}'" : string.Empty)},
                          ,[FirstName] = {user.FirstName}
                          ,[LastName] = {user.LastName}                          
                     WHERE Id = {user.Id}";
        }

        public string Add(Entity.User user)
        {
            return $@"INSERT INTO [dbo].[User]
                             ([UserName]
                             ,[HasPw]
                             ,[FirstName]
                             ,[LastName]
                             ,[Email])
                       VALUES
                             ('{user.UserName}'
                             ,'{user.HasPw}'
                             ,'{user.FirstName}'
                             ,'{user.LastName}'
                             ,'{user.Email}')
DECLARE @UserId INT = (SELECT TOP 1 ID FROM [dbo].[User] WHERE [UserName] = '{user.UserName}')
INSERT INTO [dbo].[Settings]
           ([UserId]
           ,[DisplayCategoryCards]
           ,[EnableSounds]
           ,[PageWidth]
           ,[PageHeight]
           ,[PageMargin])
     VALUES
           (@UserId
           ,1
           ,1
           ,150
           ,300
           ,10)";


        }

        internal string List()
        {
            return @"SELECT [Id]
                           ,[UserName]      
                           ,[FirstName]
                           ,[LastName]
                           ,[Email]
                     FROM [dbo].[User] WITH (NOLOCK)";
        }

        public string GetById(int userId)
        {
            return $@"SELECT [Id]
                           ,[UserName]      
                           ,[FirstName]
                           ,[LastName]
                           ,[Email]
                      FROM [dbo].[User] WITH (NOLOCK) WHERE Id = {userId}";            
        }
    }
}