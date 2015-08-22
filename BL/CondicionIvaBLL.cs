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
    public class CondicionIvaBLL
    {

        public static DataTable GetCondicionIva()
        {
            DataTable tbl = DAL.CondicionIvaDAL.GetCondicionIva();
            return tbl;
        }

        public static void GrabarDB(DataTable tblCondicionIva)
        {
            DAL.CondicionIvaDAL.GrabarDB(tblCondicionIva);
        }
    }
}
