using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.Windows.Forms;
using DAL;

namespace BL
{
    public class AlicuotasIvaBLL
    {
        public static DataTable GetAlicuotasIva()
        {
            DataTable tbl = DAL.AlicuotasIvaDAL.GetAlicuotasIva();
            return tbl;
        }

        public static void GrabarDB(DataTable tblAlicuotasIva)
        {
            DAL.AlicuotasIvaDAL.GrabarDB(tblAlicuotasIva);
        }

        public static void InsertRemotos(DataSet dt)
        {
            MySqlTransaction tr = null;
            try
            {
                MySqlConnection SqlConnection1 = DALBase.GetConnection();
                SqlConnection1.Open();
                tr = SqlConnection1.BeginTransaction();
                DAL.AlicuotasIvaDAL.InsertRemotos(dt, SqlConnection1, tr);
                tr.Commit();
                SqlConnection1.Close();
            }
            catch (MySqlException ex)
            {
                MessageBox.Show(ex.ToString(), "Trend", MessageBoxButtons.OK, MessageBoxIcon.Information);
                dt.RejectChanges();
                tr.Rollback();
            }
        }
    }
}
