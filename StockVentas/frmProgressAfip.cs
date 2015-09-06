using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Threading;

namespace StockVentas
{
    public partial class frmProgressAfip : Form
    {
        Boolean bResultado;
        DataTable tblIVA;
        DataTable tblClientes;
        DataTable tblCliente;
        DataTable tblRazonSocial;
        string strNroCbte;
        string idCliente;
        string strTipo;
        string strFechaEmision;
        Label label1;

        public frmProgressAfip(DataTable tblIva, DataTable tblClientes, string idCliente, string strTipo, string strFechaEmision)
        {
            InitializeComponent();
            this.tblIVA = tblIva;
            this.tblClientes = tblClientes;
            this.idCliente = idCliente;
            this.strTipo = strTipo;
            this.strFechaEmision = strFechaEmision;
        }

        private void frmProgressAfip_Activated(object sender, EventArgs e)
        {
            Control.CheckForIllegalCrossThreadCalls = false; // permite asignar un valor a label1.text en un subproceso diferente al principal
            label1 = new Label();
            label1.Text = "Conectando con servicio web AFIP . . .";
            label1.Location = new System.Drawing.Point(23, 23);
            label1.AutoSize = true;
            Controls.Add(label1);
            BackgroundWorker bckIniciarComponetes = new BackgroundWorker();
            bckIniciarComponetes.DoWork += new System.ComponentModel.DoWorkEventHandler(this.bckIniciarComponetes_DoWork);
            bckIniciarComponetes.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.bckIniciarComponetes_RunWorkerCompleted);
            bckIniciarComponetes.RunWorkerAsync();
        }

        private void bckIniciarComponetes_DoWork(object sender, DoWorkEventArgs e)
        {
            if (BL.Utilitarios.HayInternet())
            {
                SolicitarCAE();
            }
            else
            {
                if (this.InvokeRequired) //si da true es porque estoy en un subproceso distinto al hilo principal
                {
                    string mensaje = "No se puede iniciar la aplicación sin internet.";
                    //invoca al hilo principal através de un delegado
                    this.Invoke((Action)delegate
                    {
                        MessageBox.Show(this, mensaje, "Trend Sistemas", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        Application.Exit();
                    });
                }
            }
        }

        private void SolicitarCAE()
        {
            DataRow[] foundCliente = tblClientes.Select("IdClienteCLI = '" + idCliente + "'");
            string condicionIva = foundCliente[0]["CondicionIvaCLI"].ToString();
            int cabeceraCbteTipo = 0;
            int detalleDocTipo;
            string detalleDocNro;
            if (condicionIva == "RESPONSABLE INSCRIPTO")
            {
                detalleDocTipo = 80;
                detalleDocNro = foundCliente[0]["CUIT"].ToString();
                switch (strTipo)
                {
                    case "factura":
                        cabeceraCbteTipo = 1;
                        this.strTipo = "FACTURA";
                        break;
                    case "debito":
                        cabeceraCbteTipo = 2;
                        this.strTipo = "NOTA DE DÉBITO";
                        break;
                    case "credito":
                        cabeceraCbteTipo = 3;
                        this.strTipo = "NOTA DE CRÉDITO";
                        break;
                }
            }
            else
            {
                detalleDocTipo = 99;
                detalleDocNro = "0";
                switch (strTipo)
                {
                    case "factura":
                        cabeceraCbteTipo = 6;
                        this.strTipo = "FACTURA";
                        break;
                    case "debito":
                        cabeceraCbteTipo = 7;
                        this.strTipo = "NOTA DE DÉBITO";
                        break;
                    case "credito":
                        this.strTipo = "NOTA DE CRÉDITO";
                        cabeceraCbteTipo = 8;
                        break;
                }
            }

            // Ver WSFEv1 Fallos conexión en Camuzzo
            WSAFIPFE.Factura fe = new WSAFIPFE.Factura();
            bResultado = false;
            tblRazonSocial = BL.RazonSocialBLL.GetRazonSocial();
            string cuit = tblRazonSocial.Rows[0]["CuitRAZ"].ToString();
            bResultado = fe.iniciar(WSAFIPFE.Factura.modoFiscal.Test, cuit, @"C:\Trend\Factura-electronica\Carolina Navarro\pedido.pfx", @" ");
            if (bResultado)
            {
                fe.ArchivoCertificadoPassword = "";
                label1.Text = "Obteniendo ticket de acceso . . .";
                bResultado = fe.f1ObtenerTicketAcceso();
                if (bResultado)
                {
                    fe.F1CabeceraCantReg = 1;
                    fe.F1CabeceraPtoVta = 1;  //poner el punto de venta de la tabla razonSocial


                    /*Según el manual del desarrollador (pagina 15), el error 10007 se da por que no informas alguno de los 
                     * tipos validos son 01 02 03 04 05 34 39 60 63 para comprobantes A y 06 07 08 09 10 35 40 64 y 61 para los B.*/
                    fe.F1CabeceraCbteTipo = cabeceraCbteTipo;
                    int nroComp = fe.F1CompUltimoAutorizado(1, cabeceraCbteTipo) + 1;
                    fe.f1Indice = 0;
                    fe.F1DetalleConcepto = 1;  //Concepto del comprobante.  01-Productos, 02-Servicios, 03-Productos y Servicios
                    fe.F1DetalleDocTipo = detalleDocTipo;    // 96: DNI, 80: CUIT, 99: Consumidor Final
                    fe.F1DetalleDocNro = detalleDocNro;
                    //   fe.F1DetalleDocNro = "30570135585";
                    fe.F1DetalleCbteDesde = nroComp;
                    fe.F1DetalleCbteHasta = nroComp; // Número de comprobante hasta. En caso de ser un solo comprobante, este dato coincide con el anterior.

                    /* F1DetalleCbteFch: Fecha del comprobante, cuyo formato es "aaaammdd". Para un concepto de factura igual a 1, 
                        la fecha de emisión puede ser hasta 5 días posteriores a la de generación.  
                        Si el concepto es 2 o 3, puede ser hasta 10 días anteriores o posteriores a la fecha de generación. 
                        Al ser un dato opcional, si no se asigna fecha, por defecto se asignará la fecha del proceso.*/
                    string fecha = DateTime.Now.ToString("yyyyMMdd");
                    fe.F1DetalleCbteFch = fecha;

                    /*  fe.F1DetalleTributoItemCantidad = 1;  //preguntar Ariel Cantidad de Tributos relacionados al comprobante
                      fe.f1IndiceItem = 0;
                      fe.F1DetalleTributoId = 3;
                      fe.F1DetalleTributoDesc = "Impuesto Municipal Matanza";
                      fe.F1DetalleTributoBaseImp = 0;
                      fe.F1DetalleTributoAlic = 5.2;
                      fe.F1DetalleTributoImporte = 0;*/
                    var groupedData = from b in tblIVA.AsEnumerable()
                                      group b by b.Field<int>("IdAlicuota") into g
                                      select new
                                      {
                                          DetalleIvaId = g.Key,
                                          Count = g.Count(),
                                          DetalleIvaBaseImp = g.Sum(x => x.Field<decimal>("SubtotalSinIva")),
                                          DetalleIvaImporte = g.Sum(x => x.Field<decimal>("SubtotalIva"))
                                      };
                    int DetalleIvaItemCantidad = groupedData.Count();
                    fe.F1DetalleIvaItemCantidad = DetalleIvaItemCantidad;
                    int indiceItem = 0;
                    foreach (var registro in groupedData)
                    {
                        fe.f1IndiceItem = indiceItem;
                        //En F1DetalleIvaId va el código de la alícuota o tasa (obtenido de una lista de AFIP: 5 para 21% 4 para 10.50%, etc).
                        fe.F1DetalleIvaId = registro.DetalleIvaId;
                        fe.F1DetalleIvaBaseImp = Convert.ToDouble(registro.DetalleIvaBaseImp);  //El precio del producto
                        fe.F1DetalleIvaImporte = Convert.ToDouble(registro.DetalleIvaImporte);  //El importe del impuesto.
                        indiceItem++;
                    }


                    /*     fe.f1IndiceItem = 0;
                         fe.F1DetalleIvaId = 5;  //El código de la alícuota o tasa (obtenido de una lista de AFIP: 5 para 21% 4 para 10.50%, etc).
                         fe.F1DetalleIvaBaseImp = 100;  //El precio del producto
                         fe.F1DetalleIvaImporte = 21;  //El importe del impuesto.

                         fe.f1IndiceItem = 1;
                         fe.F1DetalleIvaId = 4;
                         fe.F1DetalleIvaBaseImp = 50;
                         fe.F1DetalleIvaImporte = 5.25;*/


                    var detalleImpNeto = tblIVA.AsEnumerable().Sum(x => x.Field<decimal>("SubtotalSinIva"));
                    var detalleImpIva = tblIVA.AsEnumerable().Sum(x => x.Field<decimal>("SubtotalIva"));
                    double detalleImpTotal = Convert.ToDouble(detalleImpNeto + detalleImpIva);

                    fe.F1DetalleImpTotal = detalleImpTotal; // total factura
                    fe.F1DetalleImpTotalConc = 0; // preguntar Ariel  Importe Neto No Grabado, debe ser mayor a cero y menor o igual al importe total (F1DetalleImpTotal).
                    fe.F1DetalleImpNeto = Convert.ToDouble(detalleImpNeto); // total bases imponibles
                    fe.F1DetalleImpOpEx = 0; // preguntar Ariel
                    fe.F1DetalleImpTrib = 0; // preguntar Ariel
                    fe.F1DetalleImpIva = Convert.ToDouble(detalleImpIva);  // total ivas
                    fe.F1DetalleFchServDesde = ""; // se debe poner fecha para servicios o para productos y servicios. Para productos solos puede ser vacío
                    fe.F1DetalleFchServHasta = ""; // Idem anterior completar si F1DetalleConcepto > 1
                    fe.F1DetalleFchVtoPago = ""; // Idem anterior completar si F1DetalleConcepto > 1
                    fe.F1DetalleMonId = "PES";
                    fe.F1DetalleMonCotiz = 1;

                    fe.F1DetalleCbtesAsocItemCantidad = 0;
                    fe.F1DetalleOpcionalItemCantidad = 0;

                    fe.ArchivoXMLRecibido = @"c:\recibido.xml";
                    fe.ArchivoXMLEnviado = @"c:\enviado.xml";
                    label1.Text = "Solicitando CAE . . .";
                    //    bResultado = fe.F1CAESolicitar();
                    if (bResultado)
                    {
                        if (this.InvokeRequired) //si da true es porque estoy en un subproceso distinto al hilo principal
                        {
                            MessageBox.Show("resultado verdadero ");
                        }                        
                    }
                    else
                    {
                        if (this.InvokeRequired) //si da true es porque estoy en un subproceso distinto al hilo principal
                        {
                            MessageBox.Show("resultado falso");
                        }  
                    }
                    if (this.InvokeRequired) //si da true es porque estoy en un subproceso distinto al hilo principal
                    {
                        MessageBox.Show("resultado global AFIP: " + fe.F1RespuestaResultado);
                        MessageBox.Show("es reproceso? " + fe.F1RespuestaReProceso);
                        MessageBox.Show("registros procesados por AFIP: " + fe.F1RespuestaCantidadReg.ToString());
                        MessageBox.Show("error genérico global:" + fe.f1ErrorMsg1);
                    }  
                    if (fe.F1RespuestaCantidadReg > 0)
                    {
                        fe.f1Indice = 0;
                        if (this.InvokeRequired) //si da true es porque estoy en un subproceso distinto al hilo principal
                        {
                            MessageBox.Show("resultado detallado comprobante: " + fe.F1RespuestaDetalleResultado);
                            MessageBox.Show("cae comprobante: " + fe.F1RespuestaDetalleCae);
                            MessageBox.Show("número comprobante:" + fe.F1RespuestaDetalleCbteDesdeS);
                            MessageBox.Show("error detallado comprobante: " + fe.F1RespuestaDetalleObservacionMsg1);
                        } 

                    }
                    tblCliente = tblClientes.Clone();
                    tblCliente.ImportRow(foundCliente[0]);
                    strNroCbte = nroComp.ToString();
                }
                else
                {
                    MessageBox.Show("fallo acceso " + fe.UltimoMensajeError);
                }
            }
            else
            {
                MessageBox.Show("error inicio " + fe.UltimoMensajeError);
            }
        }

        private void bckIniciarComponetes_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            rptFactura informeFactura = new rptFactura(tblIVA, tblCliente, tblRazonSocial, strNroCbte, strFechaEmision, strTipo);
            informeFactura.Show();
            this.Close();
        }
    }
}
