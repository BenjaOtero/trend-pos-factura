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
    public class ArticulosDAL
    {
        [ThreadStatic] static MySqlConnection SqlConnection1;
        private static MySqlDataAdapter SqlDataAdapter1;
        private static MySqlCommand SqlSelectCommand1;
        private static MySqlCommand SqlInsertCommand1;

        public static DataSet ds;
        public static DataTable dt;

        public static DataTable CrearDataset()
        {
            SqlConnection1 = DALBase.GetConnection();
            MySqlDataAdapter da = AdaptadorSELECT(SqlConnection1);
            ds = new DataSet();
            da.Fill(ds, "articulos");
            SqlConnection1.Close();
            return ds.Tables["articulos"];
        }

        private static MySqlDataAdapter AdaptadorSELECT(MySqlConnection SqlConnection1)
        {            
            SqlDataAdapter1 = new MySqlDataAdapter();
            SqlSelectCommand1 = new MySqlCommand("Articulos_Listar", SqlConnection1);
            SqlDataAdapter1.SelectCommand = SqlSelectCommand1;
            SqlSelectCommand1.CommandType = CommandType.StoredProcedure;
            return SqlDataAdapter1;
        }

        public static void GrabarDB(DataTable tblArticulos)
        {
            MySqlDataAdapter da = AdaptadorABM();
            da.Update(tblArticulos);
        }

        private static MySqlDataAdapter AdaptadorABM()
        {
            MySqlConnection SqlConnection1 = DAL.DALBase.GetConnection();
            MySqlDataAdapter SqlDataAdapter1 = new MySqlDataAdapter();
            MySqlCommand SqlInsertCommand1 = new MySqlCommand("Articulos_Insertar", SqlConnection1);
            MySqlCommand SqlUpdateCommand1 = new MySqlCommand("Articulos_Actualizar", SqlConnection1);
            MySqlCommand SqlDeleteCommand1 = new MySqlCommand("Articulos_Borrar", SqlConnection1);
            SqlDataAdapter1.DeleteCommand = SqlDeleteCommand1;
            SqlDataAdapter1.InsertCommand = SqlInsertCommand1;
            SqlDataAdapter1.UpdateCommand = SqlUpdateCommand1;

            // IMPLEMENTACIÓN DE LA ORDEN UPDATE
            SqlUpdateCommand1.Parameters.Add("p_id", MySqlDbType.VarChar, 55, "IdArticuloART");
            SqlUpdateCommand1.Parameters.Add("p_idAlicuota", MySqlDbType.Int16, 3, "IdAliculotaIvaART");
            SqlUpdateCommand1.Parameters.Add("p_descripcion", MySqlDbType.VarChar, 55, "DescripcionART");
            SqlUpdateCommand1.Parameters.Add("p_precioCosto", MySqlDbType.String, 19, "PrecioCostoART");
            SqlUpdateCommand1.Parameters.Add("p_precioPublico", MySqlDbType.String, 19, "PrecioPublicoART");
            SqlUpdateCommand1.Parameters.Add("p_precioMayor", MySqlDbType.String, 19, "PrecioMayorART");
            SqlUpdateCommand1.CommandType = CommandType.StoredProcedure;

            // IMPLEMENTACIÓN DE LA ORDEN INSERT
            SqlInsertCommand1.Parameters.Add("p_id", MySqlDbType.VarChar, 55, "IdArticuloART");
            SqlInsertCommand1.Parameters.Add("p_idAlicuota", MySqlDbType.Int16, 3, "IdAliculotaIvaART");
            SqlInsertCommand1.Parameters.Add("p_descripcion", MySqlDbType.VarChar, 55, "DescripcionART");
            SqlInsertCommand1.Parameters.Add("p_precioCosto", MySqlDbType.String, 19, "PrecioCostoART");
            SqlInsertCommand1.Parameters.Add("p_precioPublico", MySqlDbType.String, 19, "PrecioPublicoART");
            SqlInsertCommand1.Parameters.Add("p_precioMayor", MySqlDbType.String, 19, "PrecioMayorART");
            SqlInsertCommand1.CommandType = CommandType.StoredProcedure;

            // IMPLEMENTACIÓN DE LA ORDEN DELETE
            SqlDeleteCommand1.Parameters.Add("p_id", MySqlDbType.VarChar, 55, "IdArticuloART");
            SqlDeleteCommand1.CommandType = CommandType.StoredProcedure;

            return SqlDataAdapter1;
        }

    }

}
