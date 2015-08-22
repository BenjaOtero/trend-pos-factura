using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace DAL
{
    public class AlicuotasIvaDAL
    {

        public static DataTable GetAlicuotasIva()
        {
            MySqlConnection SqlConnection1 = DALBase.GetConnection();
            MySqlDataAdapter SqlDataAdapter1 = new MySqlDataAdapter();
            MySqlCommand SqlSelectCommand1 = new MySqlCommand("AlicuotasIva_Listar", SqlConnection1);
            SqlDataAdapter1.SelectCommand = SqlSelectCommand1;
            SqlSelectCommand1.CommandType = CommandType.StoredProcedure;
            DataTable tbl = new DataTable();
            SqlDataAdapter1.Fill(tbl);
            SqlConnection1.Close();
            if (!tbl.Constraints.Contains("descripcionConstraint"))
            {
                UniqueConstraint uniqueConstraint = new UniqueConstraint("descripcionConstraint", tbl.Columns["IdAlicuotaALI"]);
                tbl.Constraints.Add(uniqueConstraint);
            }
            return tbl;
        }

        public static void GrabarDB(DataTable tblAlicuotasIva)
        {
            MySqlConnection SqlConnection1 = DALBase.GetConnection();
            MySqlDataAdapter da = AdaptadorABM(SqlConnection1);
            da.Update(tblAlicuotasIva);
            SqlConnection1.Close();
        }

        private static MySqlDataAdapter AdaptadorABM(MySqlConnection SqlConnection1)
        {
            MySqlCommand SqlInsertCommand1;
            MySqlCommand SqlUpdateCommand1;
            MySqlCommand SqlDeleteCommand1;
            MySqlDataAdapter SqlDataAdapter1 = new MySqlDataAdapter();
            SqlInsertCommand1 = new MySqlCommand("AlicuotasIva_Insertar", SqlConnection1);
            SqlUpdateCommand1 = new MySqlCommand("AlicuotasIva_Actualizar", SqlConnection1);
            SqlDeleteCommand1 = new MySqlCommand("AlicuotasIva_Borrar", SqlConnection1);
            SqlDataAdapter1.DeleteCommand = SqlDeleteCommand1;
            SqlDataAdapter1.InsertCommand = SqlInsertCommand1;
            SqlDataAdapter1.UpdateCommand = SqlUpdateCommand1;

            // IMPLEMENTACIÓN DE LA ORDEN INSERT
            SqlInsertCommand1.Parameters.Add("p_id", MySqlDbType.Int16, 2, "IdAlicuotaALI");
            SqlInsertCommand1.Parameters.Add("p_porcentaje", MySqlDbType.Decimal, 12, "PorcentajeALI");
            SqlInsertCommand1.CommandType = CommandType.StoredProcedure;

            SqlUpdateCommand1.Parameters.Add("p_id", MySqlDbType.Int16, 2, "IdAlicuotaALI");
            SqlUpdateCommand1.Parameters.Add("p_porcentaje", MySqlDbType.Decimal, 12, "PorcentajeALI");
            SqlUpdateCommand1.CommandType = CommandType.StoredProcedure;

            // IMPLEMENTACIÓN DE LA ORDEN DELETE
            SqlDeleteCommand1.Parameters.Add("p_id", MySqlDbType.Int32, 2, "IdAlicuotaALI");
            SqlDeleteCommand1.CommandType = CommandType.StoredProcedure;
            return SqlDataAdapter1;
        }

        public static void InsertRemotos(DataSet dt, MySqlConnection conn, MySqlTransaction tr)
        {
            try
            {
                MySqlDataAdapter da = AdaptadorInsert(conn, tr);
                da.Update(dt, "AlicuotasIva");
            }
            catch (MySqlException ex)
            {
                MessageBox.Show(ex.ToString(), "Trend", MessageBoxButtons.OK, MessageBoxIcon.Information);
                dt.RejectChanges();
            }
        }

        private static MySqlDataAdapter AdaptadorInsert(MySqlConnection SqlConnection1, MySqlTransaction tr)
        {
            MySqlDataAdapter SqlDataAdapter1 = new MySqlDataAdapter();
            MySqlCommand SqlInsertCommand1 = new MySqlCommand("AlicuotasIva_Insertar", SqlConnection1);
            SqlInsertCommand1.Transaction = tr;
            SqlDataAdapter1.InsertCommand = SqlInsertCommand1;

            // IMPLEMENTACIÓN DE LA ORDEN INSERT
            SqlInsertCommand1.Parameters.Add("p_id", MySqlDbType.Int16, 2, "IdAlicuotaALI");
            SqlInsertCommand1.Parameters.Add("p_porcentaje", MySqlDbType.Decimal, 12, "PorcentajeALI");
            SqlInsertCommand1.CommandType = CommandType.StoredProcedure;

            return SqlDataAdapter1;
        }
    }
}
