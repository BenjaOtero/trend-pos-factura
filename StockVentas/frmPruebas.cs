using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net.Mail;
using System.Runtime.InteropServices.Marshal;
using System.Runtime.InteropServices;




namespace StockVentas
{

    public partial class frmPruebas : Form
    {

        [DllImport("MAPI32.DLL")]

        public frmPruebas()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
                MailAddress to = new MailAddress("oterobenjamin@gmailss.com");
                MailAddress from = new MailAddress("factura@trendsistemas.com", "Trend Sistemas");
                MailMessage message = new MailMessage(from, to);
                message.Subject = "Clave de producto";
                message.Body = @"Clave: ";
                SmtpClient client = new SmtpClient("mail.trendsistemas.com", 587);
                client.Credentials = new System.Net.NetworkCredential("info@trendsistemas.com", "8953#AFjn");
                client.Send(message);
        }

        private void button2_Click(object sender, EventArgs e)
        {

            using System.Runtime.InteropServices.map mapi = new MAPI();
            mapi.AddAttachment("c:\\temp\\file1.txt");
            mapi.AddAttachment("c:\\temp\\file2.txt");
            mapi.AddRecipientTo("person1@somewhere.com");
            mapi.AddRecipientTo("person2@somewhere.com");
            mapi.SendMailPopup("testing", "body text");
        }
    }
}
