using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Net.Mail;
using System.Runtime.InteropServices;
using BL;
using System.Diagnostics;






namespace StockVentas
{

    public partial class frmPruebas : Form
    {

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

            MailAddress from = new MailAddress("benjamin_otero@outlook.com");
            MailAddress to = new MailAddress("oterobenjamin@gmail.com");


            var mailMessage = new MailMessage(from, to);
          //  mailMessage.From = new MailAddress("benjamin_otero@outlook.com");
            mailMessage.Subject = "Your subject here";
            mailMessage.IsBodyHtml = true;
            mailMessage.Body = "<span style='font-size: 12pt; color: red;'>My HTML formatted body</span>";

            mailMessage.Attachments.Add(new Attachment(@"C:\enviado.xml"));

            var filename = @"C:\Windows\Temp\mymessage.eml";

            //save the MailMessage to the filesystem
            mailMessage.Save(filename);

            //Open the file with the default associated application registered on the local machine
            Process.Start(filename);

        }
    }
}
