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
    public partial class frmRazonSocial : Form
    {
        private DataTable tblRazonSocial;

        public enum FormState
        {
            inicial,
            edicion,
            insercion,
            eliminacion
        }

        public frmRazonSocial()
        {
            InitializeComponent();
            tblRazonSocial = BL.RazonSocialBLL.GetRazonSocial();            
            bindingSource1.BindingComplete += new BindingCompleteEventHandler(bindingSource1_BindingComplete);
        }

        private void frmRazonSocial_Load(object sender, EventArgs e)
        {
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
            this.ControlBox = true;
            this.MaximizeBox = false;
            FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            bindingSource1.DataSource = tblRazonSocial;
            DataTable tblCondicionIva = BL.CondicionIvaBLL.GetCondicionIva();
            cmbIdCondicionIvaRAZ.ValueMember = "IdCondicionIvaCIVA";
            cmbIdCondicionIvaRAZ.DisplayMember = "DescripcionCIVA";
            cmbIdCondicionIvaRAZ.DropDownStyle = ComboBoxStyle.DropDown;
            cmbIdCondicionIvaRAZ.DataSource = tblCondicionIva;
            BL.Utilitarios.DataBindingsAdd(bindingSource1, grpCampos);
            BL.Utilitarios.AddEventosABM(grpCampos, ref btnGrabar, ref tblRazonSocial);
            txtPuntoVentaRAZ.KeyPress += new KeyPressEventHandler(BL.Utilitarios.SoloNumeros);  
            this.txtPuntoVentaRAZ.Validated += new System.EventHandler(this.txtPuntoVentaRAZ_Validated);
            this.txtPuntoVentaRAZ.Validating += new System.ComponentModel.CancelEventHandler(this.Validar);            
            SetStateForm(FormState.inicial);
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            if (bindingSource1.Count == 0) return;
            SetStateForm(FormState.edicion);
        }

        private void btnGrabar_Click(object sender, EventArgs e)
        {
            try
            {
                int largo = txtPuntoVentaRAZ.Text.Length;
                bindingSource1.EndEdit();
                SetStateForm(FormState.inicial);
                //  bindingSource1.RemoveFilter();
            }
            catch (ConstraintException)
            {

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

        private void frmRazonSocial_FormClosing(object sender, FormClosingEventArgs e)
        {
            bindingSource1.EndEdit();
            if (tblRazonSocial.GetChanges() != null)
            {
                frmProgress progreso = new frmProgress(tblRazonSocial, "frmRazonSocial", "grabar");
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

                txtIdRazonSocialRAZ.ReadOnly = true;
                txtRazonSocialRAZ.ReadOnly = true;
                txtPuntoVentaRAZ.ReadOnly = true;
                txtNombreFantasiaRAZ.ReadOnly = true;
                txtDomicilioRAZ.ReadOnly = true;
                txtLocalidadRAZ.ReadOnly = true;
                txtProvinciaRAZ.ReadOnly = true;
                cmbIdCondicionIvaRAZ.Enabled = false;
                txtCuitRAZ.ReadOnly = true;
                txtIngresosBrutosRAZ.ReadOnly = true;
                txtInicioActividadRAZ.ReadOnly = true;
                cmbIdCondicionIvaRAZ.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                btnEditar.Enabled = true;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = false;
                btnSalir.Enabled = true;
            }

            if (state == FormState.edicion)
            {
                txtRazonSocialRAZ.ReadOnly = false;
                txtNombreFantasiaRAZ.ReadOnly = false;
                txtPuntoVentaRAZ.ReadOnly = false;
                txtDomicilioRAZ.ReadOnly = false;
                txtLocalidadRAZ.ReadOnly = false;
                txtProvinciaRAZ.ReadOnly = false;
                cmbIdCondicionIvaRAZ.Enabled = true;
                txtCuitRAZ.ReadOnly = false;
                txtIngresosBrutosRAZ.ReadOnly = false;
                txtInicioActividadRAZ.ReadOnly = false;
                btnEditar.Enabled = false;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = true;
                btnSalir.Enabled = false;
            }
        }

        private void gvwDatos_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {
            return;
        }

        private void txtPuntoVentaRAZ_Enter(object sender, EventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate()
            {
                txtPuntoVentaRAZ.SelectAll();
            });
        }

        private void txtPuntoVentaRAZ_Validating(object sender, CancelEventArgs e)
        {

        }

        private void txtPuntoVentaRAZ_Validated(object sender, EventArgs e)
        {
            errorProvider1.SetError(txtPuntoVentaRAZ, "");
        }

        private void Validar(object sender, CancelEventArgs e)
        {
            if ((sender == (object)txtPuntoVentaRAZ))
            {
                MaskedTextBox myObj = sender as MaskedTextBox;
                if (string.IsNullOrEmpty(myObj.Text))
                {
                    this.errorProvider1.SetError(txtPuntoVentaRAZ, "Debe proporcionar un número de punto de venta.");
                    e.Cancel = true;
                }
                int largo = txtPuntoVentaRAZ.Text.Length;
                if (largo < 4) e.Cancel = true;
                this.errorProvider1.SetError(txtPuntoVentaRAZ, "El punto de venta debe tener 4 dígitos.");
            }

        }

        private void txtInicioActividadRAZ_Enter(object sender, EventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate()
            {
                txtInicioActividadRAZ.SelectAll();
            });
        }

        

    }
}
