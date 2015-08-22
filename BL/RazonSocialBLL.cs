using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Windows.Forms;
using System.IO;
using DAL;

namespace BL
{
    public class RazonSocialBLL
    {

        public static DataTable GetRazonSocial()
        {
            DataTable tbl = DAL.RazonSocialDAL.GetRazonSocial();
            return tbl;
        }

        public static void GrabarDB(DataTable tblRazonSocial)
        {
            DAL.RazonSocialDAL.GrabarDB(tblRazonSocial);
        }
    }
}
