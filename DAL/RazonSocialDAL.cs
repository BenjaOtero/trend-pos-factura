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
    public class RazonSocialDAL
    {

        public static DataTable GetRazonSocial()
        {
            MySqlConnection SqlConnection1 = DALBase.GetConnection();
            MySqlDataAdapter SqlDataAdapter1 = new MySqlDataAdapter();
            MySqlCommand SqlSelectCommand1 = new MySqlCommand("RazonSocial_Listar", SqlConnection1);
            SqlDataAdapter1.SelectCommand = SqlSelectCommand1;
            SqlSelectCommand1.CommandType = CommandType.StoredProcedure;
            DataTable tbl = new DataTable();
            SqlDataAdapter1.Fill(tbl);
            SqlConnection1.Close();
            return tbl;
        }

        public static void GrabarDB(DataTable tblRazonSocial)
        {
            MySqlConnection SqlConnection1 = DALBase.GetConnection();
            MySqlDataAdapter da = AdaptadorABM(SqlConnection1);
            da.Update(tblRazonSocial);
            SqlConnection1.Close();
        }

        private static MySqlDataAdapter AdaptadorABM(MySqlConnection SqlConnection1)
        {
            MySqlCommand SqlInsertCommand1;
            MySqlCommand SqlUpdateCommand1;
            MySqlCommand SqlDeleteCommand1;
            MySqlDataAdapter SqlDataAdapter1 = new MySqlDataAdapter();
            SqlInsertCommand1 = new MySqlCommand("RazonSocial_Insertar", SqlConnection1);
            SqlUpdateCommand1 = new MySqlCommand("RazonSocial_Actualizar", SqlConnection1);
            SqlDeleteCommand1 = new MySqlCommand("RazonSocial_Borrar", SqlConnection1);
            SqlDataAdapter1.DeleteCommand = SqlDeleteCommand1;
            SqlDataAdapter1.InsertCommand = SqlInsertCommand1;
            SqlDataAdapter1.UpdateCommand = SqlUpdateCommand1;


            // IMPLEMENTACIÓN DE LA ORDEN UPDATE
            SqlUpdateCommand1.Parameters.Add("p_id", MySqlDbType.Int32, 2, "IdRazonSocialRAZ");
            SqlUpdateCommand1.Parameters.Add("p_razon", MySqlDbType.VarChar, 50, "RazonSocialRAZ");
            SqlUpdateCommand1.Parameters.Add("p_nombre", MySqlDbType.VarChar, 50, "NombreFantasiaRAZ");
            SqlUpdateCommand1.Parameters.Add("p_domicilio", MySqlDbType.VarChar, 50, "DomicilioRAZ");
            SqlUpdateCommand1.Parameters.Add("p_localidad", MySqlDbType.VarChar, 50, "LocalidadRAZ");
            SqlUpdateCommand1.Parameters.Add("p_provincia", MySqlDbType.VarChar, 50, "ProvinciaRAZ");
            SqlUpdateCommand1.Parameters.Add("p_idCondicionIva", MySqlDbType.Int32, 2, "IdCondicionIvaRAZ");
            SqlUpdateCommand1.Parameters.Add("p_cuit", MySqlDbType.VarChar, 50, "CuitRAZ");
            SqlUpdateCommand1.Parameters.Add("p_ingresosB", MySqlDbType.VarChar, 50, "IngresosBrutosRAZ");
            SqlUpdateCommand1.Parameters.Add("p_inicio", MySqlDbType.DateTime, 50, "InicioActividadRAZ");
            SqlUpdateCommand1.Parameters.Add("p_punto", MySqlDbType.String, 4, "PuntoVentaRAZ");
            SqlUpdateCommand1.CommandType = CommandType.StoredProcedure;

            // IMPLEMENTACIÓN DE LA ORDEN INSERT
            SqlInsertCommand1.Parameters.Add("p_id", MySqlDbType.Int32, 2, "IdRazonSocialRAZ");
            SqlInsertCommand1.Parameters.Add("p_razon", MySqlDbType.VarChar, 50, "RazonSocialRAZ");
            SqlInsertCommand1.Parameters.Add("p_nombre", MySqlDbType.VarChar, 50, "NombreFantasiaRAZ");
            SqlInsertCommand1.Parameters.Add("p_domicilio", MySqlDbType.VarChar, 50, "DomicilioRAZ");
            SqlInsertCommand1.Parameters.Add("p_localidad", MySqlDbType.VarChar, 50, "LocalidadRAZ");
            SqlInsertCommand1.Parameters.Add("p_provincia", MySqlDbType.VarChar, 50, "ProvinciaRAZ");
            SqlInsertCommand1.Parameters.Add("p_idCondicionIva", MySqlDbType.Int32, 2, "IdCondicionIvaRAZ");
            SqlInsertCommand1.Parameters.Add("p_cuit", MySqlDbType.VarChar, 50, "CuitRAZ");
            SqlInsertCommand1.Parameters.Add("p_ingresosB", MySqlDbType.VarChar, 50, "IngresosBrutosRAZ");
            SqlInsertCommand1.Parameters.Add("p_inicio", MySqlDbType.DateTime, 50, "InicioActividadRAZ");
            SqlInsertCommand1.Parameters.Add("p_punto", MySqlDbType.String, 4, "PuntoVentaRAZ");
            SqlInsertCommand1.CommandType = CommandType.StoredProcedure;

            // IMPLEMENTACIÓN DE LA ORDEN DELETE
            SqlDeleteCommand1.Parameters.Add("p_id", MySqlDbType.Int32, 2, "IdRazonSocialRAZ");
            SqlDeleteCommand1.CommandType = CommandType.StoredProcedure;
            return SqlDataAdapter1;
        }

    }
}