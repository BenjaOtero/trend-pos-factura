using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;
using System.IO;
using System.Net.Mail;
using BL;
using System.Diagnostics;

namespace StockVentas
{
    public partial class rptFactura : Form
    {
        DataTable tblIVA;
        DataTable tblRazonSocial;
        DataTable tblCliente;
        string strNroComp;
        string strFechaEmision;
        string codigoComprobante;
        string strTipo;

        public rptFactura(DataTable tblIVA, DataTable tblCliente, DataTable tblRazonSocial, string strNroComp, string strFechaEmision, string strTipo)
        {
            InitializeComponent();
            this.tblIVA = tblIVA;
            this.tblRazonSocial = tblRazonSocial;
            this.tblCliente = tblCliente;
            this.strNroComp = strNroComp;
            this.strFechaEmision = strFechaEmision;
            this.strTipo = strTipo;
        }

        private void rptFactura_Load(object sender, EventArgs e)
        {
            ToolStripButton btnMail = new ToolStripButton();
            btnMail.Image = Properties.Resources.email;
            btnMail.ToolTipText = "Enviar por correo electrónico";
            btnMail.Click += new System.EventHandler(this.btnMail_Click);
            ToolStrip toolStrip = (ToolStrip)reportViewer1.Controls.Find("toolStrip1", true)[0];
            toolStrip.Items.Add(btnMail);

            string cabeceraCbteTipo;            
            int condicionIva = Convert.ToInt16(tblCliente.Rows[0]["CondicionIvaCLI"].ToString());            
            if (condicionIva == 1)
            {
                cabeceraCbteTipo = "A";
                switch (strTipo)
                {
                    case "FACTURA":
                        codigoComprobante = "COD.01";
                        break;
                    case "NOTA DE DÉBITO":
                        codigoComprobante = "COD.02";
                        break;
                    case "NOTA DE CRÉDITO":
                        codigoComprobante = "COD.03";
                        break;
                }
            }
            else
            {
                cabeceraCbteTipo = "B";
                switch (strTipo)
                {
                    case "FACTURA":
                        codigoComprobante = "COD.06";
                        break;
                    case "NOTA DE DÉBITO":
                        codigoComprobante = "COD.07";
                        break;
                    case "NOTA DE CRÉDITO":
                        codigoComprobante = "COD.08";
                        break;
                }
            }

            ReportParameter[] parametros = new ReportParameter[5];
            parametros[0] = new ReportParameter("prmtrCabeceraCbteTipo", cabeceraCbteTipo);
            parametros[1] = new ReportParameter("prmtrCodigoComprobante", codigoComprobante);
            parametros[2] = new ReportParameter("prmtrFechaEmision", strFechaEmision);
            parametros[3] = new ReportParameter("prmtrNroCbte", strNroComp);
            parametros[4] = new ReportParameter("prmtrTipo", strTipo);
            this.reportViewer1.ProcessingMode = ProcessingMode.Local;
            string path = Application.StartupPath + @"\Informes\factura.rdlc";
            this.reportViewer1.LocalReport.ReportPath = path;
            reportViewer1.LocalReport.DataSources.Add(new ReportDataSource("dsTablaIva", tblIVA));
            reportViewer1.LocalReport.DataSources.Add(new ReportDataSource("dsRazonSocial", tblRazonSocial));
            reportViewer1.LocalReport.DataSources.Add(new ReportDataSource("dsCliente", tblCliente));
            this.reportViewer1.LocalReport.SetParameters(parametros);
            this.reportViewer1.RefreshReport();
            this.HorizontalScroll.Enabled = false;            
        }

        private void btnMail_Click(object sender, EventArgs e)
        {
            CreatePDF();
            MailAddress from = null;
            MailAddress to = null;
            if (!string.IsNullOrEmpty(tblRazonSocial.Rows[0]["CorreoRAZ"].ToString()))
            {
                from = new MailAddress(tblRazonSocial.Rows[0]["CorreoRAZ"].ToString());
            }
            else
            {
                MessageBox.Show("Debe ingresar una dirección de correo en los datos de la empresa", "TREND", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            if (!string.IsNullOrEmpty(tblCliente.Rows[0]["CorreoCLI"].ToString()))
            {
                to = new MailAddress(tblCliente.Rows[0]["CorreoCLI"].ToString());
            }
            else
            {
                to = new MailAddress("destinatario@dominio.com");
            }            
            var mailMessage = new MailMessage(from, to);
            mailMessage.Subject = "Your subject here";
            mailMessage.IsBodyHtml = true;
            //    mailMessage.Body = "<span style='font-size: 12pt; color: red;'>My HTML formatted body</span>";
            mailMessage.Attachments.Add(new Attachment(@"c:\windows\temp\output.pdf"));
            var filename = @"C:\Windows\Temp\message.eml";
            //save the MailMessage to the filesystem
            mailMessage.Save(filename); // utilizo el metodo save de la clase MailUtility en Utilitarios.cs
            //Open the file with the default associated application registered on the local machine
            Process.Start(filename);
        }

        void CreatePDF()
        {
            Warning[] warnings;
            string[] streamids;
            string mimeType;
            string encoding;
            string extension;
            byte[] bytes = reportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamids, out warnings);
            FileStream fs = new FileStream(@"c:\windows\temp\output.pdf",FileMode.Create);
            fs.Write(bytes, 0, bytes.Length);
            fs.Close();
        }
    }
}
