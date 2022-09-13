using System;
using System.IO;
using System.Web.UI;
using WebApplication.Business;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication.Control
{
    public partial class Upload : UserControl
    {
        ContextBase contextBase;
        CategoryBusiness categoryBusiness;

        public Upload()
        {
            contextBase = new ContextBase();
            categoryBusiness = new CategoryBusiness();
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Category.DataSource = categoryBusiness.List(contextBase);
            Category.DataTextField = "Description";
            Category.DataValueField = "Id";
            Category.DataBind();
        }

        protected void save_Click(object sender, System.EventArgs e)
        {
            if (imgProduct.HasFile)
            {
                try
                {
                    FileInfo fileInfo = new FileInfo(imgProduct.FileName);
                    string path = Path.Combine(AppContext.BaseDirectory, "upload", "product");
                    string file = Guid.NewGuid().ToString("N") + fileInfo.Extension;
                    string fileName = Path.Combine(path, file);

                    imgProduct.SaveAs(fileName);

                    Product product = new Product()
                    {
                        Description = Description.Text,
                        Price = decimal.Parse(Price.Text),
                        UrlImg = file,
                        CategoryId = int.Parse(Category.SelectedValue),
                    };

                    ProductBusiness.Save(product);

                    Page.RegisterStartupScript("reload", @"location.href = ""/Home.aspx"";");
                }
                catch
                {
                    throw new Exception();
                }
            }
        }
    }
}