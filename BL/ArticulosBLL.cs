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
    public class ArticulosBLL
    {
        public DataTable tblArticulos;
        public DataTable tblArticulosItems;
        public DataTable tblColores;
        public DataTable tblProveedores;
        public DataTable tblLocales;

        public static DataTable CrearDataset()
        {
            DataTable dt = DAL.ArticulosDAL.CrearDataset();
            return dt;
        }

        public static void GrabarDB(DataTable tblArticulos)
        {
            DAL.ArticulosDAL.GrabarDB(tblArticulos);
        }

    }
}
