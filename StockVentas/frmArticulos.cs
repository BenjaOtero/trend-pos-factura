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

        public frmArticulos()
        {
            InitializeComponent();
            tblArticulos = BL.DatosPosBLL.Articulos();
            BL.Utilitarios.AddEventosABM(grpCampos, ref btnGrabar, ref tblArticulos);
            bindingSource1.BindingComplete += new BindingCompleteEventHandler(bindingSource1_BindingComplete);
        }

        private void frmArticulos_Load(object sender, EventArgs e)
        {
            this.AutoValidate = System.Windows.Forms.AutoValidate.EnablePreventFocusChange;
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
            this.Text = "Artículos";
            this.ControlBox = true;
            this.MaximizeBox = false;

            FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            bindingSource1.DataSource = tblArticulos;
            bindingNavigator1.BindingSource = bindingSource1;            
            gvwDatos.DataSource = bindingSource1;
            gvwDatos.SelectionMode = DataGridViewSelectionMode.FullRowSelect;
            gvwDatos.Columns["IdArticuloART"].HeaderText = "Código";
            gvwDatos.Columns["DescripcionART"].HeaderText = "Descripción";
            gvwDatos.Columns["PrecioPublicoART"].HeaderText = "Precio";
            gvwDatos.Columns["PrecioCostoART"].Visible = false;
            gvwDatos.Columns["PrecioMayorART"].Visible = false;
            gvwDatos.Columns["IdAliculotaIvaART"].Visible = false;
            gvwDatos.Columns["PorcentajeALI"].Visible = false;
            bindingSource1.Sort = "DescripcionART";
            DataTable tblAlicuotas = BL.AlicuotasIvaBLL.GetAlicuotasIva();
            cmbIdAliculotaIvaART.ValueMember = "IdAlicuotaALI";
            cmbIdAliculotaIvaART.DisplayMember = "PorcentajeALI";
            cmbIdAliculotaIvaART.DropDownStyle = ComboBoxStyle.DropDown;
            cmbIdAliculotaIvaART.DataSource = tblAlicuotas;
            cmbIdAliculotaIvaART.SelectedValue = -1;
            BL.Utilitarios.DataBindingsAdd(bindingSource1, grpCampos);
            btnCancelar.CausesValidation = false;
            grpBotones.CausesValidation = false;
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
            bindingSource1.Filter = "DescripcionART LIKE '*" + parametros + "*' OR IdArticuloART  LIKE '" + parametros + "*'";
        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {                       
            bindingSource1.AddNew();
            bindingSource1.Position = bindingSource1.Count - 1;
            txtIdArticuloART.ReadOnly = false;
            txtIdArticuloART.Text = GenerarCodigo();
            txtIdArticuloART.ReadOnly = true;
            cmbIdAliculotaIvaART.SelectedValue = 1;
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
                string mensaje = "No se puede agregar el artículo '" + txtDescripcionART.Text.ToUpper() + "' porque ya existe";
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
                BL.ArticulosBLL.GrabarDB(tblArticulos);
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

        private string GenerarCodigo()
        {
            DataTable tblArticulosCopia = tblArticulos.Copy();
            tblArticulosCopia.AcceptChanges();
            DataTable tbl = new DataTable();
            tbl.Columns.Add("Id", typeof(int));
            tbl.PrimaryKey = new DataColumn[] { tbl.Columns["Id"] };
            foreach (DataRow rowArticulo in tblArticulosCopia.Rows)
            {
                DataRow nuevaFila;
                nuevaFila = tbl.NewRow();
                nuevaFila[0] = Convert.ToInt32(rowArticulo["IdArticuloART"].ToString());
                tbl.Rows.Add(nuevaFila);
            }
            int buscado = 1;
            bool existe = true;
            while (existe == true)
            {
                DataRow foundRow;
                foundRow = tbl.Rows.Find(buscado);
                if (foundRow == null) existe = false;
                else buscado++;                
            }
            string codigo = Convert.ToString(buscado);
            if (codigo.Length == 1) codigo = "00" + codigo;
            else if (codigo.Length == 2) codigo = "0" + codigo;            
            return codigo;
        }

        private void Validar(object sender, CancelEventArgs e)
        {
            if ((sender == (object)txtDescripcionART) && string.IsNullOrEmpty(txtDescripcionART.Text))
            {
                this.errorProvider1.SetError(txtDescripcionART, "Debe escribir una descripción del artículo.");
                e.Cancel = true;
            }
            if ((sender == (object)txtPrecioPublicoART) && string.IsNullOrEmpty(txtPrecioPublicoART.Text))
            {
                this.errorProvider1.SetError(txtPrecioPublicoART, "Debe escribir un precio.");
                e.Cancel = true;
            }

            if ((sender == (object)cmbIdAliculotaIvaART) && string.IsNullOrEmpty(cmbIdAliculotaIvaART.Text))
            {
                this.errorProvider1.SetError(cmbIdAliculotaIvaART, "Debe seleccionar una alícuota de IVA.");
                e.Cancel = true;
            }
        }

        private void Validado(object sender, EventArgs e)
        {
            if ((sender == (object)txtDescripcionART)) this.errorProvider1.SetError(txtDescripcionART, "");
            if ((sender == (object)txtPrecioPublicoART)) this.errorProvider1.SetError(txtPrecioPublicoART, "");
            if ((sender == (object)cmbIdAliculotaIvaART)) this.errorProvider1.SetError(cmbIdAliculotaIvaART, "");                     
        }

    }
}
