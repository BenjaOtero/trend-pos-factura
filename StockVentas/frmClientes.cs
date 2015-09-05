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
    public partial class frmClientes : Form
    {
        frmVentas instanciaVentas = null;
        private DataTable tblClientes;
        private DataTable tblCondicionIva;
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

        public frmClientes()
        {
          InitializeComponent();
        }

        public frmClientes(ref frmVentas instanciaVentas)
        {
            InitializeComponent();
            this.instanciaVentas = instanciaVentas;
        }

        private void frmClientes_Load(object sender, EventArgs e)
        {
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
            this.ControlBox = true;
            this.MaximizeBox = false;
            FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            tblClientes = BL.DatosPosBLL.Clientes();
            BL.Utilitarios.AddEventosABM(grpCampos, ref btnGrabar, ref tblClientes);
            bindingSource1.DataSource = tblClientes;
            bindingNavigator1.BindingSource = bindingSource1;
            tblCondicionIva = BL.CondicionIvaBLL.GetCondicionIva();
            cmbCondicionIvaCLI.DataSource = tblCondicionIva;
            cmbCondicionIvaCLI.DisplayMember = "DescripcionCIVA";
            cmbCondicionIvaCLI.ValueMember = "IdCondicionIvaCIVA";
            AutoCompleteStringCollection condicionColection = new AutoCompleteStringCollection();
            foreach (DataRow row in tblCondicionIva.Rows)
            {
                condicionColection.Add(Convert.ToString(row["DescripcionCIVA"]));
            }
            cmbCondicionIvaCLI.AutoCompleteCustomSource = condicionColection;
            cmbCondicionIvaCLI.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
            cmbCondicionIvaCLI.AutoCompleteSource = AutoCompleteSource.CustomSource;
            cmbCondicionIvaCLI.Validating += new System.ComponentModel.CancelEventHandler(BL.Utilitarios.ValidarComboBox);            
            gvwDatos.DataSource = bindingSource1;
            gvwDatos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            gvwDatos.Columns["IdClienteCLI"].HeaderText = "Nº cliente";
            gvwDatos.Columns["RazonSocialCLI"].HeaderText = "Razon social";
            gvwDatos.Columns["CUIT"].HeaderText = "Número de CUIT"; ;
            gvwDatos.Columns["DireccionCLI"].Visible = false;
            gvwDatos.Columns["LocalidadCLI"].Visible = false;
            gvwDatos.Columns["ProvinciaCLI"].Visible = false;
            gvwDatos.Columns["TransporteCLI"].Visible = false;
            gvwDatos.Columns["ContactoCLI"].Visible = false;
            gvwDatos.Columns["TelefonoCLI"].Visible = false;
            gvwDatos.Columns["MovilCLI"].Visible = false;
            gvwDatos.Columns["CorreoCLI"].Visible = false;
            gvwDatos.Columns["CondicionIvaCLI"].Visible = false;
            gvwDatos.Columns["DescripcionCIVA"].Visible = false;
            bindingSource1.Sort = "RazonSocialCLI";
            int itemFound = bindingSource1.Find("RazonSocialCLI", "JUAN PEREZS");
            bindingSource1.Position = itemFound;
            foreach (Control ctl in grpCampos.Controls)
            {
                if (ctl is TextBox || ctl is MaskedTextBox || ctl is ComboBox)
                {
                    ctl.Validating += new System.ComponentModel.CancelEventHandler(this.Validar);
                    ctl.Validated += new System.EventHandler(this.Validado);
                }
            }
            BL.Utilitarios.DataBindingsAdd(bindingSource1, grpCampos);
            bindingSource1.BindingComplete += new BindingCompleteEventHandler(bindingSource1_BindingComplete);
            grpBotones.CausesValidation = false;
            btnCancelar.CausesValidation = false;
            txtParametros.ForeColor = System.Drawing.SystemColors.InactiveCaption;
            txtParametros.Text = "Ingrese CUIT o nombre";
            SetStateForm(FormState.inicial);  
        }        

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            string parametros = txtParametros.Text;
            bindingSource1.Filter = "RazonSocialCLI LIKE '" + parametros + "*' OR CUIT LIKE '" + parametros + "'";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            bindingSource1.AddNew();
            Random rand = new Random();
            int clave = rand.Next(1, 2000000000);
            bindingSource1.Position = bindingSource1.Count - 1;
            txtIdClienteCLI.ReadOnly = false;
            txtIdClienteCLI.Text = clave.ToString();
            txtIdClienteCLI.ReadOnly = true;
            txtRazonSocialCLI.Focus();
            SetStateForm(FormState.insercion);  
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {
            if (txtRazonSocialCLI.Text == "PUBLICO")
            {
                MessageBox.Show("No se puede modificar el registro porque es un registro propio del sistema.", "Trend Gestión",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            } 
            SetStateForm(FormState.edicion);
        }

        private void btnBorrar_Click(object sender, EventArgs e)
        {
            if (txtRazonSocialCLI.Text == "PUBLICO")
            {
                MessageBox.Show("No se puede borrar el registro porque es un registro propio del sistema.", "Trend Gestión",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
                return;
            } 
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
                bindingSource1.Sort = "RazonSocialCLI";
                SetStateForm(FormState.inicial);
                bindingSource1.RemoveFilter();
            }
            catch (ConstraintException)
            {
                string mensaje = "No se puede agregar el cliente '" + txtRazonSocialCLI.Text.ToUpper() + "' porque ya existe un cliente con el mismo número de CUIT";
                MessageBox.Show(mensaje, "Trend", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtCUIT.Focus();                
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

        private void frmClientes_FormClosing(object sender, FormClosingEventArgs e)
        {
            bindingSource1.EndEdit();
            if (tblClientes.GetChanges() != null)
            {
                 BL.ClientesBLL.GrabarDB(tblClientes);
            }
            bindingSource1.RemoveFilter();
            if (instanciaVentas != null) instanciaVentas.idCliente = Convert.ToInt32(txtIdClienteCLI.Text);
        }

        private void Validar(object sender, CancelEventArgs e)
        {
            if ((sender == (object)txtRazonSocialCLI))
            {
                if (string.IsNullOrEmpty(txtRazonSocialCLI.Text))
                {
                    this.errorProvider1.SetError(txtRazonSocialCLI, "Debe escribir una razón social.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtCUIT))
            {
                if (string.IsNullOrEmpty(txtCUIT.Text))
                {
                    this.errorProvider1.SetError(txtCUIT, "Debe escribir un número de CUIT.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)cmbCondicionIvaCLI))
            {
                if (string.IsNullOrEmpty(cmbCondicionIvaCLI.Text))
                {
                    this.errorProvider1.SetError(cmbCondicionIvaCLI, "Debe seleccionar una condición frente al IVA.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtDireccionCLI))
            {
                if (string.IsNullOrEmpty(txtDireccionCLI.Text))
                {
                    this.errorProvider1.SetError(txtDireccionCLI, "Debe escribir un domicilio.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtLocalidadCLI))
            {
                if (string.IsNullOrEmpty(txtLocalidadCLI.Text))
                {
                    this.errorProvider1.SetError(txtLocalidadCLI, "Debe escribir una localidad.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtProvinciaCLI))
            {
                if (string.IsNullOrEmpty(txtProvinciaCLI.Text))
                {
                    this.errorProvider1.SetError(txtProvinciaCLI, "Debe escribir una provincia.");
                    e.Cancel = true;
                }
            }
            if ((sender == (object)txtCorreoCLI))
            {
                if (!Utilitarios.IsValidEmail(txtCorreoCLI.Text))
                {
                    this.errorProvider1.SetError(txtCorreoCLI, "La dirección de correo es inválida.");
                    e.Cancel = true;
                }
            }
        }

        private void Validado(object sender, EventArgs e)
        {
            if ((sender == (object)txtRazonSocialCLI))
            {
                this.errorProvider1.SetError(txtRazonSocialCLI, "");
            }
            if ((sender == (object)txtCUIT))
            {
                this.errorProvider1.SetError(txtCUIT, "");
            }
            if ((sender == (object)cmbCondicionIvaCLI))
            {
                this.errorProvider1.SetError(cmbCondicionIvaCLI, "");
            }
            if ((sender == (object)txtDireccionCLI))
            {
                this.errorProvider1.SetError(txtDireccionCLI, "");
            }
            if ((sender == (object)txtLocalidadCLI))
            {
                this.errorProvider1.SetError(txtLocalidadCLI, "");
            }
            if ((sender == (object)txtProvinciaCLI))
            {
                this.errorProvider1.SetError(txtProvinciaCLI, "");
            }
            if ((sender == (object)txtCorreoCLI))
            {
                this.errorProvider1.SetError(txtCorreoCLI, "");
            }
        }

        private void txtParametros_Enter(object sender, EventArgs e)
        {
            txtParametros.Clear();
            txtParametros.ForeColor = System.Drawing.SystemColors.ControlText;            
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
                txtIdClienteCLI.ReadOnly = true;
                txtIdClienteCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtRazonSocialCLI.ReadOnly = true;
                txtRazonSocialCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtCUIT.ReadOnly = true;
                txtCUIT.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtDireccionCLI.ReadOnly = true;
                txtDireccionCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtLocalidadCLI.ReadOnly = true;
                txtLocalidadCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtProvinciaCLI.ReadOnly = true;
                txtProvinciaCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtTransporteCLI.ReadOnly = true;
                txtTransporteCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtContactoCLI.ReadOnly = true;
                txtContactoCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtTelefonoCLI.ReadOnly = true;
                txtTelefonoCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtMovilCLI.ReadOnly = true;
                txtMovilCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                txtCorreoCLI.ReadOnly = true;
                txtCorreoCLI.BackColor = System.Drawing.SystemColors.ActiveCaptionText;
                btnBuscar.Enabled = true;
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
                txtRazonSocialCLI.ReadOnly = false;
                txtCUIT.ReadOnly = false;
                txtDireccionCLI.ReadOnly = false;
                txtLocalidadCLI.ReadOnly = false;
                txtProvinciaCLI.ReadOnly = false;
                txtTransporteCLI.ReadOnly = false;
                txtContactoCLI.ReadOnly = false;
                txtTelefonoCLI.ReadOnly = false;
                txtMovilCLI.ReadOnly = false;
                txtCorreoCLI.ReadOnly = false;
                txtRazonSocialCLI.Clear();
                txtCUIT.Clear();
                txtDireccionCLI.Clear();
                txtLocalidadCLI.Clear();
                txtProvinciaCLI.Clear();
                txtTransporteCLI.Clear();
                txtContactoCLI.Clear();
                txtTelefonoCLI.Clear();
                txtMovilCLI.Clear();
                txtCorreoCLI.Clear();
                txtRazonSocialCLI.Focus();
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
                txtRazonSocialCLI.ReadOnly = false;
                txtCUIT.ReadOnly = false;
                txtDireccionCLI.ReadOnly = false;
                txtLocalidadCLI.ReadOnly = false;
                txtProvinciaCLI.ReadOnly = false;
                txtTransporteCLI.ReadOnly = false;
                txtContactoCLI.ReadOnly = false;
                txtTelefonoCLI.ReadOnly = false;
                txtMovilCLI.ReadOnly = false;
                txtCorreoCLI.ReadOnly = false;
                txtRazonSocialCLI.Focus();
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
