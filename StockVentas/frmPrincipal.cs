using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using BL;
using System.Diagnostics;
using System.Threading;

namespace StockVentas
{
    public partial class frmPrincipal : Form
    {
        frmInicio instanciaInicio;
        public frmProgress progreso;

        public frmPrincipal(frmInicio instanciaInicio)
        {
            InitializeComponent();
            foreach (Control control in this.Controls)
            {
                MdiClient client = control as MdiClient;
                if (!(client == null))
                {
                    client.BackColor = this.BackColor;
                    break;
                }
            }
            this.instanciaInicio = instanciaInicio;
        }

        private void frmPrincipal_Load(object sender, EventArgs e)
        {
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
        }

        private void alícuotasIVAToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmAlicuotasIva newMDIChild = new frmAlicuotasIva();
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

        private void clientesToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            frmClientes newMDIChild = new frmClientes();
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

        private void condiciónIVAToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmCondicionIva newMDIChild = new frmCondicionIva();
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

        private void datosEmpresaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmRazonSocial newMDIChild = new frmRazonSocial();
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

        private void ventasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            frmVentas newMDIChild = new frmVentas("factura");
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
            Cursor.Current = Cursors.Arrow;
        }

        private void toolStripCredito_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            frmVentas newMDIChild = new frmVentas("credito");
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
            Cursor.Current = Cursors.Arrow;
        }

        private void toolStripDebito_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            frmVentas newMDIChild = new frmVentas("debito");
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
            Cursor.Current = Cursors.Arrow;
        }

        private void arqueoDeCajaToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            frmArqueoInter newMDIChild = new frmArqueoInter();
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

        private void btnArticulos_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            frmArticulos articulos = new frmArticulos();
            articulos.Show();
            Cursor.Current = Cursors.Arrow;
        }

        private void actualizarDatos_Click(object sender, EventArgs e)
        {
            frmProgress newMDIChild = new frmProgress("ActualizarBD", "cargar");
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

        private void salirToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void frmPrincipal_FormClosing(object sender, FormClosingEventArgs e)
        {
            instanciaInicio.cerrando = true;
            instanciaInicio.Visible = true;
        }

        private void threadToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Thread t = new Thread(() => bckWrk_DoWork());
            t.Start();
        }

        public static void bckWrk_DoWork()
        {
          //  DataSet ds = BL.Utilitarios.ActualizarBD();
        }

        private void pruebaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmPruebas newMDIChild = new frmPruebas();
            newMDIChild.MdiParent = this;
            newMDIChild.Show();
        }

    }
}
