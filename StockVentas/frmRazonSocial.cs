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
        private const int CP_NOCLOSE_BUTTON = 0x200;  //junto con protected override CreateParams inhabilitan el boton cerrar de frmProgress

        protected override CreateParams CreateParams
        {
            get
            {
                CreateParams myCp = base.CreateParams;
                myCp.ClassStyle = myCp.ClassStyle | CP_NOCLOSE_BUTTON;
                return myCp;
            }
        } 

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
            this.AutoValidate = System.Windows.Forms.AutoValidate.EnablePreventFocusChange;
            btnCancelar.CausesValidation = false;
            grpBotones.CausesValidation = false;
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
            this.txtPuntoVentaRAZ.Validating += new System.ComponentModel.CancelEventHandler(this.Validar);
            foreach (Control ctl in grpCampos.Controls)
            {
                if (ctl is TextBox || ctl is MaskedTextBox || ctl is ComboBox)
                {
                    ctl.Validating += new System.ComponentModel.CancelEventHandler(this.Validar);
                    ctl.Validated += new System.EventHandler(this.Validado);                    
                }
            }

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

        private void Validar(object sender, CancelEventArgs e)
        {
            if ((sender == (object)txtRazonSocialRAZ))
            {
                if (string.IsNullOrEmpty(txtRazonSocialRAZ.Text))
                {
                    this.errorProvider1.SetError(txtRazonSocialRAZ, "Debe escribir una razón social.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtPuntoVentaRAZ))
            {
                int largo = txtPuntoVentaRAZ.Text.Length;
                if (largo < 4) e.Cancel = true;
                this.errorProvider1.SetError(txtPuntoVentaRAZ, "El punto de venta debe tener 4 dígitos.");
            }
            if ((sender == (object)txtNombreFantasiaRAZ))
            {
                if (string.IsNullOrEmpty(txtNombreFantasiaRAZ.Text))
                {
                    this.errorProvider1.SetError(txtNombreFantasiaRAZ, "Debe escribir un nombre de fantasía.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtDomicilioRAZ))
            {
                if (string.IsNullOrEmpty(txtDomicilioRAZ.Text))
                {
                    this.errorProvider1.SetError(txtDomicilioRAZ, "Debe escribir un domicilio.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtLocalidadRAZ))
            {
                if (string.IsNullOrEmpty(txtLocalidadRAZ.Text))
                {
                    this.errorProvider1.SetError(txtLocalidadRAZ, "Debe escribir una localidad.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtProvinciaRAZ))
            {
                if (string.IsNullOrEmpty(txtProvinciaRAZ.Text))
                {
                    this.errorProvider1.SetError(txtProvinciaRAZ, "Debe escribir una provincia.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)cmbIdCondicionIvaRAZ))
            {
                if (string.IsNullOrEmpty(cmbIdCondicionIvaRAZ.Text))
                {
                    this.errorProvider1.SetError(cmbIdCondicionIvaRAZ, "Debe seleccionar una condición frente al IVA.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtCuitRAZ))
            {
                if (string.IsNullOrEmpty(txtCuitRAZ.Text))
                {
                    this.errorProvider1.SetError(txtCuitRAZ, "Debe escribir un número de CUIT.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtIngresosBrutosRAZ))
            {
                if (string.IsNullOrEmpty(txtIngresosBrutosRAZ.Text))
                {
                    this.errorProvider1.SetError(txtIngresosBrutosRAZ, "Debe escribir un número de Ingresos Brutos.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtInicioActividadRAZ))
            {
                if (string.IsNullOrEmpty(txtInicioActividadRAZ.Text))
                {
                    this.errorProvider1.SetError(txtInicioActividadRAZ, "Debe escribir una fecha.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtCorreoRAZ))
            {
                if (string.IsNullOrEmpty(txtCorreoRAZ.Text))
                {
                    this.errorProvider1.SetError(txtCorreoRAZ, "Debe escribir una dirección de correo.");
                    e.Cancel = true;
                }
                else
                {
                    if (!Utilitarios.IsValidEmail(txtCorreoRAZ.Text))
                    {
                        this.errorProvider1.SetError(txtCorreoRAZ, "La dirección de correo es invalida.");
                        e.Cancel = true;
                    }
                }
            }
        }

        private void Validado(object sender, EventArgs e)
        {
            if ((sender == (object)txtRazonSocialRAZ))
            {
                this.errorProvider1.SetError(txtRazonSocialRAZ, "");
            }
            if ((sender == (object)txtPuntoVentaRAZ))
            {
                this.errorProvider1.SetError(txtPuntoVentaRAZ, "");
            }
            if ((sender == (object)txtNombreFantasiaRAZ))
            {
                this.errorProvider1.SetError(txtNombreFantasiaRAZ, "");
            }
            if ((sender == (object)txtDomicilioRAZ))
            {
                this.errorProvider1.SetError(txtDomicilioRAZ, "");
            }
            if ((sender == (object)txtLocalidadRAZ))
            {
                this.errorProvider1.SetError(txtLocalidadRAZ, "");
            }
            if ((sender == (object)txtProvinciaRAZ))
            {
                this.errorProvider1.SetError(txtProvinciaRAZ, "");
            }
            if ((sender == (object)cmbIdCondicionIvaRAZ))
            {
                this.errorProvider1.SetError(cmbIdCondicionIvaRAZ, "");
            }
            if ((sender == (object)txtCuitRAZ))
            {
                this.errorProvider1.SetError(txtCuitRAZ, "");
            }
            if ((sender == (object)txtIngresosBrutosRAZ))
            {
                this.errorProvider1.SetError(txtIngresosBrutosRAZ, "");
            }
            if ((sender == (object)txtInicioActividadRAZ))
            {
                this.errorProvider1.SetError(txtInicioActividadRAZ, "");
            }
            if ((sender == (object)txtCorreoRAZ))
            {
                this.errorProvider1.SetError(txtCorreoRAZ, "");
            }
        }

        private void txtInicioActividadRAZ_Enter(object sender, EventArgs e)
        {
            this.BeginInvoke((MethodInvoker)delegate()
            {
                txtInicioActividadRAZ.SelectAll();
            });
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
                txtCorreoRAZ.ReadOnly = true;
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
                txtCorreoRAZ.ReadOnly = false;
                btnEditar.Enabled = false;
                btnGrabar.Enabled = false;
                btnCancelar.Enabled = true;
                btnSalir.Enabled = false;
                txtRazonSocialRAZ.Focus();
            }
        }

    }
}
