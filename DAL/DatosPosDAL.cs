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
    public class DatosPosDAL
    {
        public static DataSet datos;

        public static DataSet GetDatos()
        {
            MySqlConnection SqlConnection1;
            MySqlDataAdapter SqlDataAdapter1;
            MySqlCommand SqlSelectCommand1;
            SqlConnection1 = DALBase.GetConnection();
            SqlDataAdapter1 = new MySqlDataAdapter();
            SqlSelectCommand1 = new MySqlCommand("DatosPos_Listar", SqlConnection1);
            SqlDataAdapter1.SelectCommand = SqlSelectCommand1;
            SqlSelectCommand1.CommandType = CommandType.StoredProcedure;
            datos = new DataSet();
            SqlDataAdapter1.Fill(datos);
            SqlConnection1.Close();
            return datos;
        }        

        public static DataTable Articulos()
        {
            DataTable tblArticulos = datos.Tables[0];
            tblArticulos.TableName = "Articulos";
            return tblArticulos;
        }

        public static DataTable Clientes()
        {
            DataTable tblClientes = datos.Tables[1];
            tblClientes.TableName = "clientes";
            if (!tblClientes.Constraints.Contains("descripcionConstraint"))
            {
                UniqueConstraint uniqueConstraint = new UniqueConstraint("descripcionConstraint", tblClientes.Columns["CUIT"]);
                tblClientes.Constraints.Add(uniqueConstraint);
            }
            return tblClientes;
        }
    }

}
