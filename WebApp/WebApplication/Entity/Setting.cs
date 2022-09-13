using System.Data;

namespace WebApplication.Entity
{
    public class Setting
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public bool DisplayCategoryCards { get; set; }
        public bool EnableSounds { get; set; }
        public int PageWidth { get; set; }
        public int PageHeight { get; set; }
        public int PageMargin { get; set; }
        public User User { get; set; }
        public Setting()
        {

        }

        public Setting(DataTable dtSetting)
        {
            if (dtSetting != null && dtSetting.Rows !=  null)
            {
                Id = int.Parse(dtSetting.Rows[0]["Id"].ToString());
                UserId = int.Parse(dtSetting.Rows[0]["UserId"].ToString());
                DisplayCategoryCards = bool.Parse(dtSetting.Rows[0]["DisplayCategoryCards"].ToString());
                EnableSounds = bool.Parse(dtSetting.Rows[0]["EnableSounds"].ToString());
                PageWidth = int.Parse(dtSetting.Rows[0]["PageWidth"].ToString());
                PageHeight = int.Parse(dtSetting.Rows[0]["PageHeight"].ToString());
                PageMargin = int.Parse(dtSetting.Rows[0]["PageMargin"].ToString());

                User = new User(dtSetting);
            }
        }
    }
}
