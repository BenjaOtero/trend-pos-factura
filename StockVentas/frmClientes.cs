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
        DataTable tblFallidas;

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
            tblCondicionIva = BL.CondicionIvaBLL.GetCondicionIva();
            BL.Utilitarios.AddEventosABM(grpCampos, ref btnGrabar, ref tblClientes);
            tblFallidas = new DataTable();
            tblFallidas.TableName = "ClientesFallidas";
            tblFallidas.Columns.Add("Id", typeof(int));
            tblFallidas.Columns.Add("Accion", typeof(string));
            tblFallidas.Columns["Id"].Unique = true;
            tblFallidas.PrimaryKey = new DataColumn[] { tblFallidas.Columns["Id"] };
            DataView viewClientes = new DataView(tblClientes);
            bindingSource1.DataSource = viewClientes;
            bindingNavigator1.BindingSource = bindingSource1;
            tblCondicionIva = BL.CondicionIvaBLL.GetCondicionIva();
            cmbCondicionIvaCLI.DataSource = tblCondicionIva;
            cmbCondicionIvaCLI.DisplayMember = "DescripcionCIVA";
            cmbCondicionIvaCLI.ValueMember = "IdCondicionIvaCIVA";
            AutoCompleteStringCollection condicionColection = new AutoCompleteStringCollection();
            foreach (DataRow row in tblClientes.Rows)
            {
                condicionColection.Add(Convert.ToString(row["DescripcionCIVA"]));
            }
            cmbCondicionIvaCLI.AutoCompleteCustomSource = condicionColection;
            cmbCondicionIvaCLI.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
            cmbCondicionIvaCLI.AutoCompleteSource = AutoCompleteSource.CustomSource;
            cmbCondicionIvaCLI.Validating += new System.ComponentModel.CancelEventHandler(BL.Utilitarios.ValidarComboBox);
            BL.Utilitarios.DataBindingsAdd(bindingSource1, grpCampos);
            gvwDatos.DataSource = bindingSource1;
            gvwDatos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            gvwDatos.Columns["IdClienteCLI"].HeaderText = "Nº cliente";
            gvwDatos.Columns["RazonSocialCLI"].HeaderText = "Razon social";
            gvwDatos.Columns["CUIT"].Visible = false;
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
            int itemFound = bindingSource1.Find("RazonSocialCLI", "PUBLICO");
            bindingSource1.Position = itemFound;
            tblClientes.RowChanging += new DataRowChangeEventHandler(Row_Changing);
            tblClientes.RowDeleting += new DataRowChangeEventHandler(Row_Deleting);
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
            tblClientes.RowChanging -= new DataRowChangeEventHandler(Row_Changing);
            bindingSource1.EndEdit();
            if (tblClientes.GetChanges() != null)
            {
                 BL.ClientesBLL.GrabarDB(tblClientes);
            }
            bindingSource1.RemoveFilter();
            if (instanciaVentas != null) instanciaVentas.idCliente = Convert.ToInt32(txtIdClienteCLI.Text);
        }

        private void Row_Deleting(object sender, DataRowChangeEventArgs e)
        {
            int clave = Convert.ToInt32(e.Row["IdClienteCLI"].ToString());
            DataRow foundRow = tblFallidas.Rows.Find(clave);
            if (foundRow != null)
            {
                string accionNueva = e.Action.ToString();
                string accionAnterior = foundRow["Accion"].ToString();
                switch (accionAnterior)
                {
                    case "Add":
                        foundRow.Delete();
                        break;
                    case "Change":
                        foundRow["Accion"] = "Delete";
                        break;
                }
            }
            else
            {
                DataRow row = tblFallidas.NewRow();
                row["Id"] = Convert.ToInt32(e.Row["IdClienteCLI"].ToString());
                row["Accion"] = e.Action.ToString(); ;
                tblFallidas.Rows.Add(row);
            }
        }

        private void Row_Changing(object sender, DataRowChangeEventArgs e)
        {
            int clave = Convert.ToInt32(e.Row["IdClienteCLI"].ToString());
            DataRow foundRow = tblFallidas.Rows.Find(clave);
            if (foundRow != null)
            {
                string accionNueva = e.Action.ToString();
                string accionAnterior = foundRow["Accion"].ToString();
                if (accionAnterior == "delete" && accionNueva == "add") //coincide el id de registro borrado con el nuevo añadido
                {
                    foundRow["Accion"] = "change";
                }
            }
            else
            {
                DataRow row = tblFallidas.NewRow();
                row["Id"] = Convert.ToInt32(e.Row["IdClienteCLI"].ToString());
                row["Accion"] = e.Action.ToString(); ;
                tblFallidas.Rows.Add(row);
            }
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

    }
}
