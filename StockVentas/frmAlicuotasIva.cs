using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace StockVentas
{
    public partial class frmAlicuotasIva : Form
    {
        private DataTable tblAlicuotasIva;

        public enum FormState
        {
            inicial,
            edicion,
            insercion,
            eliminacion
        }

        public frmAlicuotasIva()
        {
            InitializeComponent();
            tblAlicuotasIva = BL.AlicuotasIvaBLL.GetAlicuotasIva();
            BL.Utilitarios.AddEventosABM(grpCampos, ref btnGrabar, ref tblAlicuotasIva);
            bindingSource1.BindingComplete += new BindingCompleteEventHandler(bindingSource1_BindingComplete);
            txtIdAlicuotaALI.KeyPress += new System.Windows.Forms.KeyPressEventHandler(BL.Utilitarios.SoloNumeros);
            txtPorcentajeALI.KeyPress += new System.Windows.Forms.KeyPressEventHandler(BL.Utilitarios.SoloNumerosConComa);            
        }

        private void frmAlicuotasIva_Load(object sender, EventArgs e)
        {
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
            this.ControlBox = true;
            this.MaximizeBox = false;
            FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            bindingSource1.DataSource = tblAlicuotasIva;
            bindingNavigator1.BindingSource = bindingSource1;
            BL.Utilitarios.DataBindingsAdd(bindingSource1, grpCampos);
            gvwDatos.DataSource = bindingSource1;
            gvwDatos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            gvwDatos.Columns["IdAlicuotaALI"].HeaderText = "ID";
            gvwDatos.Columns["PorcentajeALI"].HeaderText = "Porcentaje";
            bindingSource1.Sort = "IdAlicuotaALI";
            SetStateForm(FormState.inicial);   
        }        

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            bindingSource1.AddNew();

            DataTable tmp = tblAlicuotasIva.Copy();
            tmp.AcceptChanges();
            // utilizo tmp porque si hay filas borradas en tblCondicionIva el select max da error
            var maxValue = tmp.Rows.OfType<DataRow>().Select(row => row["IdAlicuotaALI"]).Max();
            int clave = Convert.ToInt32(maxValue) + 1;
            bindingSource1.Position = bindingSource1.Count - 1;
            txtIdAlicuotaALI.ReadOnly = false;
            txtIdAlicuotaALI.Text = clave.ToString();
            txtIdAlicuotaALI.ReadOnly = true;
            txtPorcentajeALI.Focus();
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
            bindingSource1.Sort = "IdAlicuotaALI";
            SetStateForm(FormState.inicial);
            }
            catch (ConstraintException ex)
            {
                bool b;
                if (b = ex.Message.ToString().Contains("IdAlicuotaALI"))
                {
                    string mensaje = "No se puede agregar el ID '" + txtIdAlicuotaALI.Text.ToUpper() + "' porque ya existe";
                    MessageBox.Show(mensaje, "Trend", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtIdAlicuotaALI.Focus();
                }
                else
                {
                    string mensaje = "No se puede agregar el porcentaje '" + txtPorcentajeALI.Text.ToUpper() + "' porque ya existe";
                    MessageBox.Show(mensaje, "Trend", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    txtPorcentajeALI.Focus();
                }                

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

        private void frmAlicuotasIva_FormClosing(object sender, FormClosingEventArgs e)
        {
            bindingSource1.EndEdit();
            if (tblAlicuotasIva.GetChanges() != null)
            {
                DataTable tbl = tblAlicuotasIva.GetChanges();
                frmProgress progreso = new frmProgress(tblAlicuotasIva, "frmAlicuotasIva", "grabar");
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
                txtPorcentajeALI.ReadOnly = true;
                txtPorcentajeALI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                btnNuevo.Enabled = true;
                btnEditar.Enabled = true;
                btnBorrar.Enabled = true;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = false;
                btnSalir.Enabled = true;
            }

            if (state == FormState.insercion)
            {
                gvwDatos.Enabled = false;
                txtIdAlicuotaALI.ReadOnly = false;
                txtPorcentajeALI.ReadOnly = false;
                txtPorcentajeALI.Clear();
                txtIdAlicuotaALI.Focus();
                btnNuevo.Enabled = false;
                btnEditar.Enabled = false;
                btnBorrar.Enabled = false;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = true;
                btnSalir.Enabled = false;
                txtPorcentajeALI.Focus();
            }

            if (state == FormState.edicion)
            {
                gvwDatos.Enabled = false;
                txtIdAlicuotaALI.ReadOnly = false;
                txtPorcentajeALI.ReadOnly = false;
                txtIdAlicuotaALI.Focus();
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
