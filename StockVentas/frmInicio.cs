using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.ServiceProcess;
using System.IO;
using System.Diagnostics;
using System.Net;
using System.Net.NetworkInformation;
using System.Threading;
using System.Timers;
using BL;
using MySql.Data;
using MySql.Data.MySqlClient;

namespace StockVentas
{

    public partial class frmInicio : Form
    {
        frmInicio instanciaInicio;
        BackgroundWorker bckIniciarComponetes;
        private static System.Timers.Timer timer;
        bool existeServicio;
        Label label1;
        public DataSet ds;
        public bool cerrando = false;
        private int? codigoError = null;

        public frmInicio()
        {
            InitializeComponent();
            instanciaInicio = this;  
        }

        private void frmInicio_Shown(object sender, EventArgs e)
        {
            System.Drawing.Icon ico = Properties.Resources.icono_app;
            this.Icon = ico;
            Control.CheckForIllegalCrossThreadCalls = false; // permite asignar un valor a label1.text en un subproceso diferente al principal
            label1 = new Label();
            label1.Text = "Comprobando conexión de red. . .";
            label1.Location = new System.Drawing.Point(28, 190);
            label1.AutoSize = true;
            Controls.Add(label1);
            bckIniciarComponetes = new BackgroundWorker();
            bckIniciarComponetes.DoWork += new System.ComponentModel.DoWorkEventHandler(this.bckIniciarComponetes_DoWork);
            bckIniciarComponetes.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.bckIniciarComponetes_RunWorkerCompleted);
            bckIniciarComponetes.RunWorkerAsync();
        }

        private void frmInicio_Activated(object sender, EventArgs e)
        {
            if (cerrando)
            {
                timer = new System.Timers.Timer(500);
                timer.Elapsed += new ElapsedEventHandler(CerrarAplicacion);
                timer.Enabled = true;
                timer.AutoReset = false;
            }
        }

        private void bckIniciarComponetes_DoWork(object sender, DoWorkEventArgs e)
        {
            if (BL.Utilitarios.HayInternet())
            {
                if (!ExisteServicioMySQL())
                {
                    label1.Text = "Configurando servidor de base de datos . . .";
                    ConfigurarMySQL();
                }
                DataSet ds = BL.DatosPosBLL.GetDatos();
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

        private void bckIniciarComponetes_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            IniciarAplicacion();
        }

        private void ConfigurarMySQL()
        {
            System.IO.StreamWriter sw = System.IO.File.CreateText("c:\\Windows\\Temp\\config_mysql.bat"); // creo el archivo .bat
            sw.Close();
            string programFiles = "C:\\Program files";
            if (Directory.Exists(programFiles))
            {
                programFiles = programFiles.Substring(3, programFiles.Length - 3);
            }
            else
            {
                programFiles = "Archivos de programa";
            }
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("C:");
            string configMysql = "cd " + "\"C:\\" + programFiles + "\\MySQL\\MySQL Server 5.5\\bin\"";
            sb.AppendLine(configMysql);
            configMysql = "mysqlinstanceconfig.exe -i -q ServiceName=MySQL root Password=8953#AFjn ServerType=DEVELOPER DatabaseType=INODB Port=myport Charset=utf8";
            sb.AppendLine(configMysql);
            string rutaDB = Application.StartupPath.ToString() + @"\Mysql\pos.sql";
            string restaurarDB = "mysql.exe -u root < \"" + rutaDB + "\"";
            sb.AppendLine(restaurarDB);
            string usuario = "mysql.exe -u root -e \"GRANT ALL ON *.* TO 'ncsoftwa_re'@'%' IDENTIFIED BY '1234#JJlo' WITH GRANT OPTION; FLUSH PRIVILEGES;\"";
            sb.AppendLine(usuario);
            using (StreamWriter outfile = new StreamWriter("c:\\Windows\\Temp\\config_mysql.bat", true)) // escribo en el archivo .bat
            {
                outfile.Write(sb.ToString());
            }
            Process process = new Process();
            process.StartInfo.FileName = "c:\\Windows\\Temp\\config_mysql.bat";
            process.StartInfo.CreateNoWindow = false;
            process.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
            process.Start();
            process.EnableRaisingEvents = true;
            process.WaitForExit();
            StringBuilder sb_myIni = new StringBuilder();
            sb_myIni.AppendLine("");
            sb_myIni.AppendLine("[mysqld]");
            sb_myIni.AppendLine("lower_case_table_names = 0");
            using (StreamWriter file = new StreamWriter("C:\\" + programFiles + "\\MySQL\\MySQL Server 5.5\\my.ini", true))
            {
                file.Write(sb_myIni.ToString());
            }
        }

        private bool ExisteServicioMySQL()
        {
            existeServicio = false;
            ServiceController[] scServices;
            scServices = ServiceController.GetServices();
            foreach (ServiceController scTemp in scServices)
            {
                if (scTemp.ServiceName == "MySQL")
                {
                    existeServicio = true;
                    continue;
                }
            }
            return existeServicio;
        }

        private void IniciarAplicacion()
        {
            this.Visible = false;
            frmPrincipal principal = new frmPrincipal(instanciaInicio);
            principal.Show();
        }

        private void CerrarAplicacion(object source, ElapsedEventArgs e)
        {
            int n = 0;
            do
            {
                ProcessThreadCollection currentThreads = Process.GetCurrentProcess().Threads;
                foreach (ProcessThread thread in currentThreads)
                {
                    if (thread.ThreadState == System.Diagnostics.ThreadState.Running)
                    {
                        n++;
                    }
                }
                if (n > 1) Thread.Sleep(5000);                
            } while (n > 1);

            Application.Exit();
        }

    }
}
