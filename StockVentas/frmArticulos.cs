using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using BL;

namespace StockVentas
{
    public partial class frmArticulos : Form
    {
        private DataTable tblArticulos;

        public enum FormState
        {
            inicial,
            edicion,
            insercion,
            eliminacion
        }

        public frmArticulos()
        {
            InitializeComponent();
            tblArticulos = BL.DatosPosBLL.Articulos();
            BL.Utilitarios.AddEventosABM(grpCampos, ref btnGrabar, ref tblArticulos);
            bindingSource1.BindingComplete += new BindingCompleteEventHandler(bindingSource1_BindingComplete);
        }

        private void frmArticulos_Load(object sender, EventArgs e)
        {
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
            this.ControlBox = true;
            this.MaximizeBox = false;
            FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            bindingSource1.DataSource = tblArticulos;
            bindingNavigator1.BindingSource = bindingSource1;
            BL.Utilitarios.DataBindingsAdd(bindingSource1, grpCampos);
            gvwDatos.DataSource = bindingSource1;
            gvwDatos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            gvwDatos.Columns["IdArticuloART"].HeaderText = "Código";
            gvwDatos.Columns["DescripcionART"].HeaderText = "Descripción";
            gvwDatos.Columns["PrecioPublicoART"].HeaderText = "Precio";
            gvwDatos.Columns["PrecioCostoART"].Visible = false;
            gvwDatos.Columns["PrecioMayorART"].Visible = false;
            gvwDatos.Columns["IdAliculotaIvaART"].Visible = false;
            bindingSource1.Sort = "DescripcionART";
            SetStateForm(FormState.inicial);   
        }        

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            string parametros = txtParametros.Text;
            bindingSource1.Filter = "DescripcionART LIKE '*" + parametros + "*' OR IdArticuloART  LIKE '" + parametros + "*'";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            bindingSource1.AddNew();
            DataTable tmp = tblArticulos.Copy();
            tmp.AcceptChanges();
            // utilizo tmp porque si hay filas borradas en tblArticulos el select max da error
            var maxValue = tmp.Rows.OfType<DataRow>().Select(row => row["IdFormaPagoFOR"]).Max();
            int clave = Convert.ToInt32(maxValue) + 1;
            bindingSource1.Position = bindingSource1.Count - 1;
            txtIdArticuloART.ReadOnly = false;
            txtIdArticuloART.Text = clave.ToString();
            txtIdArticuloART.ReadOnly = true;
            txtDescripcionART.Focus();
            SetStateForm(FormState.insercion);   
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            if (bindingSource1.Count == 0) return;
            SetStateForm(FormState.edicion);
        }

        private void btnBorrar_Click(object sender, EventArgs e)
        {
            if (bindingSource1.Count == 0) return;
            if (MessageBox.Show("¿Desea borrar este registro?", "Buscar", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
            {
                bindingSource1.RemoveCurrent();
                bindingSource1.EndEdit();
            }
            SetStateForm(FormState.inicial); 
        }

        private void btnGrabar_Click(object sender, EventArgs e)
        {
            try
            {
            bindingSource1.EndEdit();
            bindingSource1.Position = 0;
            bindingSource1.Sort = "DescripcionART";
            SetStateForm(FormState.inicial);
            }
            catch (ConstraintException)
            {
                string mensaje = "No se puede agregar la forma de pago '" + txtDescripcionART.Text.ToUpper() + "' porque ya existe";
                MessageBox.Show(mensaje, "Trend", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtDescripcionART.Focus();
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            bindingSource1.CancelEdit();
            SetStateForm(FormState.inicial);
        }

        private void btnSalir_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void frmArticulos_FormClosing(object sender, FormClosingEventArgs e)
        {
            bindingSource1.EndEdit();
            if (tblArticulos.GetChanges() != null)
            {
                frmProgress progreso = new frmProgress(tblArticulos, "frmArticulos", "grabar");
                progreso.ShowDialog();
            }
            bindingSource1.RemoveFilter();
        }

        private void bindingSource1_BindingComplete(object sender, BindingCompleteEventArgs e)
        {
            // Check if the data source has been updated, and that no error has occured.
            if (e.BindingCompleteContext ==
                BindingCompleteContext.DataSourceUpdate && e.Exception == null)

                // If not, end the current edit.
                e.Binding.BindingManagerBase.EndCurrentEdit();
        }

        public void SetStateForm(FormState state)
        {

            if (state == FormState.inicial)
            {
                gvwDatos.Enabled = true;
                txtDescripcionART.ReadOnly = true;
                txtDescripcionART.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                btnBuscar.Enabled = true;
                btnNuevo.Enabled = true;
                btnEditar.Enabled = true;
                btnBorrar.Enabled = true;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = false;
                btnSalir.Enabled = true;
                txtParametros.Focus();
            }

            if (state == FormState.insercion)
            {
                gvwDatos.Enabled = false;
                txtDescripcionART.ReadOnly = false;
                txtDescripcionART.Clear();
                txtDescripcionART.Focus();
                btnBuscar.Enabled = false;
                btnNuevo.Enabled = false;
                btnEditar.Enabled = false;
                btnBorrar.Enabled = false;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = true;
                btnSalir.Enabled = false;
            }

            if (state == FormState.edicion)
            {
                gvwDatos.Enabled = false;
                txtDescripcionART.ReadOnly = false;
                txtDescripcionART.Focus();
                btnBuscar.Enabled = false;
                btnNuevo.Enabled = false;
                btnEditar.Enabled = false;
                btnBorrar.Enabled = false;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = true;
                btnSalir.Enabled = false;
            }
        }

        private void gvwDatos_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            return;
        }

    }
}
