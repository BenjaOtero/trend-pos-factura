using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.IO;
using System.Windows.Forms;
using DAL;


namespace BL
{
    public class DatosPosBLL
    {

        public static DataSet GetDatos()
        {
            DataSet datos = DAL.DatosPosDAL.GetDatos();
            return datos;
        }

        public static DataTable Articulos()
        {
            DataTable tblArticulos = DAL.DatosPosDAL.Articulos();
            return tblArticulos;
        }

        public static DataTable Clientes()
        {
            DataTable tblClientes = DAL.DatosPosDAL.Clientes();
            return tblClientes;
        }

    }
}
