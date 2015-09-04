using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using MySql.Data;
using MySql.Data.MySqlClient;
using System.IO;
using System.Windows.Forms;
using System.ComponentModel;
using DAL;
using System.Threading;

namespace BL
{
    public class ClientesBLL 
    {
        private static object _sync = new object();

        public static DataSet GetClientes()
        {
            DataSet dt = DAL.ClientesDAL.GetClientes();            
            return dt;
        }

        // Obtiene el registro del cliente que se grabó localmente pero falló la grabación remota
        public static DataSet GetRegistroFallido(int idCliente)
        {
            DataSet ds = new DataSet();
            ds = DAL.ClientesDAL.GetRegistroFallido(idCliente);
            return ds;
        }

        public static void GrabarDB(DataTable tbl)
        {
            DAL.ClientesDAL.GrabarDB(tbl);
        }


        // Inserta los datos remotos obtenidos del servidor al iniciar la aplicación (Tablas articulos, clientes, FormasPago)
        public static void InsertRemotos(DataSet dt)
        {
            MySqlTransaction tr = null;
            try
            {
                MySqlConnection SqlConnection1 = DALBase.GetConnection();
                SqlConnection1.Open();
                tr = SqlConnection1.BeginTransaction();
                DAL.ClientesDAL.InsertRemotos(dt, SqlConnection1, tr);
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

        /*----------------------------Acciones en tabla clientesfallidas----------------------------------*/

        // si falla la grabacion remota utilizo un hilo secundario para grabar la informacion en la tabla local clientesfallidas
        private static void ThreadSaveEnClientesFallidas(DataTable tblFallidas)
        {
            DataTable tblClientesFallidas = DAL.FallidasDAL.GetClienteFallida();
            foreach (DataRow row in tblFallidas.Rows)
            {
                int PK = Convert.ToInt32(row["Id"].ToString());
                DataRow foundRow = tblClientesFallidas.Rows.Find(PK);
                if (foundRow != null)
                {
                    string accionNueva = row["Accion"].ToString();
                    string accionAnterior = foundRow["Accion"].ToString();
                    switch (accionAnterior)
                    {
                        case "Add":
                            if (accionNueva == "Delete")
                            {
                                DAL.FallidasDAL.BorrarClienteFallidasByPK(PK);
                            }
                            break;
                        case "Change":
                            if (accionNueva == "Delete")
                            {
                                foundRow["Accion"] = "Delete";
                            }
                            break;
                        case "Delete":
                            if (accionNueva == "Add")
                            {
                                foundRow["Accion"] = "Change";
                            }
                            break;
                    }
                }
                else
                {
                    DataRow rowFallida = tblClientesFallidas.NewRow();
                    rowFallida["Id"] = PK;
                    rowFallida["Accion"] = row["Accion"].ToString();
                    tblClientesFallidas.Rows.Add(rowFallida);
                }
            }
            if (tblClientesFallidas.GetChanges() != null)
            {
                DataSet ds = new DataSet();
                ds.Tables.Add(tblClientesFallidas);
                DAL.FallidasDAL.GrabarClienteFallidas(ds);
            }
        }

        // Obtiene los registros de la tabla clientesfallidas por accion (delete, add, change)
        public static DataTable ClienteGetByAccion(string accion)
        {
            DataTable tbl = DAL.ClientesDAL.ClienteGetByAccion(accion);
            return tbl;
        }

        // Borra los registros de la tabla clientesfallidas por accion (delete, add, change)
        public static void BorrarClienteFallidasByAccion(string accion)
        {
            DAL.ClientesDAL.BorrarClienteFallidasByAccion(accion);
        }

    }
}
