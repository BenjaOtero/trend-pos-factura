using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;

namespace StockVentas
{
    public partial class rptFactura : Form
    {
        DataTable tblIVA;
        DataTable tblRazonSocial;
        DataTable tblCliente;
        string strNroComp;
        string strFechaEmision;

        public rptFactura(DataTable tblIVA, DataTable tblCliente, DataTable tblRazonSocial, string strNroComp, string strFechaEmision)
        {
            InitializeComponent();
            this.tblIVA = tblIVA;
            this.tblRazonSocial = tblRazonSocial;
            this.tblCliente = tblCliente;
            this.strNroComp = strNroComp;
            this.strFechaEmision = strFechaEmision;
        }

        private void rptFactura_Load(object sender, EventArgs e)
        {
            string cabeceraCbteTipo;
            string codigoComprobante;
            int condicionIva = Convert.ToInt16(tblCliente.Rows[0]["CondicionIvaCLI"].ToString());            
            if (condicionIva == 1)
            {
                cabeceraCbteTipo = "A";
                codigoComprobante = "COD.01";
            }
            else
            {
                cabeceraCbteTipo = "B";
                codigoComprobante = "COD.06";
            }

            ReportParameter[] parametros = new ReportParameter[4];
            parametros[0] = new ReportParameter("prmtrCabeceraCbteTipo", cabeceraCbteTipo);
            parametros[1] = new ReportParameter("prmtrCodigoComprobante", codigoComprobante);
            parametros[2] = new ReportParameter("prmtrFechaEmision", strFechaEmision);
            parametros[3] = new ReportParameter("prmtrNroCbte", strNroComp);


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
    }
}
