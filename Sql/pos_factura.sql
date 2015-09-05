/*
SQLyog Ultimate v9.02 
MySQL - 5.5.0-m2-community : Database - pos_factura
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pos_factura` /*!40100 DEFAULT CHARACTER SET utf8 */;

/*Table structure for table `alicuotasiva` */

DROP TABLE IF EXISTS `alicuotasiva`;

CREATE TABLE `alicuotasiva` (
  `IdAlicuotaALI` tinyint(2) NOT NULL,
  `PorcentajeALI` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`IdAlicuotaALI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `alicuotasiva` */

LOCK TABLES `alicuotasiva` WRITE;

insert  into `alicuotasiva`(`IdAlicuotaALI`,`PorcentajeALI`) values (1,'21.00'),(2,'10.50');

UNLOCK TABLES;

/*Table structure for table `articulos` */

DROP TABLE IF EXISTS `articulos`;

CREATE TABLE `articulos` (
  `IdArticuloART` varchar(50) NOT NULL,
  `IdAliculotaIvaART` tinyint(2) DEFAULT NULL,
  `DescripcionART` varchar(55) DEFAULT NULL,
  `PrecioCostoART` decimal(19,0) DEFAULT NULL,
  `PrecioPublicoART` decimal(19,0) DEFAULT NULL,
  `PrecioMayorART` decimal(19,0) DEFAULT NULL,
  PRIMARY KEY (`IdArticuloART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `articulos` */

LOCK TABLES `articulos` WRITE;

insert  into `articulos`(`IdArticuloART`,`IdAliculotaIvaART`,`DescripcionART`,`PrecioCostoART`,`PrecioPublicoART`,`PrecioMayorART`) values ('001',1,'PANTALON JEAN',NULL,'150',NULL),('002',1,'CAMPERA JEAN CORTA',NULL,'150',NULL),('004',1,'BERMUDA',NULL,'200',NULL);

UNLOCK TABLES;

/*Table structure for table `clientes` */

DROP TABLE IF EXISTS `clientes`;

CREATE TABLE `clientes` (
  `IdClienteCLI` int(11) NOT NULL,
  `RazonSocialCLI` varchar(50) DEFAULT NULL,
  `CUIT` varchar(50) DEFAULT NULL,
  `CondicionIvaCLI` varchar(50) DEFAULT NULL,
  `DireccionCLI` varchar(50) DEFAULT NULL,
  `LocalidadCLI` varchar(50) DEFAULT NULL,
  `ProvinciaCLI` varchar(50) DEFAULT NULL,
  `TransporteCLI` varchar(50) DEFAULT NULL,
  `ContactoCLI` varchar(50) DEFAULT NULL,
  `TelefonoCLI` varchar(50) DEFAULT NULL,
  `MovilCLI` varchar(50) DEFAULT NULL,
  `CorreoCLI` varchar(60) DEFAULT NULL,
  `FechaNacCLI` datetime DEFAULT NULL,
  PRIMARY KEY (`IdClienteCLI`),
  KEY `IdClienteCLI` (`IdClienteCLI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `clientes` */

LOCK TABLES `clientes` WRITE;

insert  into `clientes`(`IdClienteCLI`,`RazonSocialCLI`,`CUIT`,`CondicionIvaCLI`,`DireccionCLI`,`LocalidadCLI`,`ProvinciaCLI`,`TransporteCLI`,`ContactoCLI`,`TelefonoCLI`,`MovilCLI`,`CorreoCLI`,`FechaNacCLI`) values (1,'CONSUMIDOR FINAL','','3','','','','','','','','correo@dominio.com',NULL),(1495736341,'BENJAMIN OTERO','23173850379','2','OCOCHA 2340','SAN SALVADOR','JUJUY',NULL,NULL,NULL,NULL,'oterobenjamin@gmail.com',NULL),(1970745042,'JUAN PEREZ','30570135585','1','CHACO 23','CORDOBA','CORDOBA',NULL,NULL,NULL,NULL,'juanperez@dominio.com',NULL);

UNLOCK TABLES;

/*Table structure for table `clientesfallidas` */

DROP TABLE IF EXISTS `clientesfallidas`;

CREATE TABLE `clientesfallidas` (
  `Id` int(11) DEFAULT NULL,
  `Accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `clientesfallidas` */

LOCK TABLES `clientesfallidas` WRITE;

UNLOCK TABLES;

/*Table structure for table `condicioniva` */

DROP TABLE IF EXISTS `condicioniva`;

CREATE TABLE `condicioniva` (
  `IdCondicionIvaCIVA` tinyint(2) NOT NULL,
  `DescripcionCIVA` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IdCondicionIvaCIVA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `condicioniva` */

LOCK TABLES `condicioniva` WRITE;

insert  into `condicioniva`(`IdCondicionIvaCIVA`,`DescripcionCIVA`) values (1,'RESPONSABLE INSCRIPTO'),(2,'RESPONSABLE MONOTRIBUTO'),(3,'CONSUMIDOR FINAL'),(4,'EXENTO'),(5,'NO RESPONSABLE');

UNLOCK TABLES;

/*Table structure for table `fondocaja` */

DROP TABLE IF EXISTS `fondocaja`;

CREATE TABLE `fondocaja` (
  `IdFondoFONP` int(11) DEFAULT NULL,
  `FechaFONP` datetime NOT NULL,
  `IdPcFONP` int(11) NOT NULL,
  `ImporteFONP` double DEFAULT NULL,
  PRIMARY KEY (`FechaFONP`,`IdPcFONP`),
  KEY `FK_FondoCaja` (`IdPcFONP`),
  CONSTRAINT `FK_FondoCaja` FOREIGN KEY (`IdPcFONP`) REFERENCES `pc` (`IdPC`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fondocaja` */

LOCK TABLES `fondocaja` WRITE;

insert  into `fondocaja`(`IdFondoFONP`,`FechaFONP`,`IdPcFONP`,`ImporteFONP`) values (848171385,'2015-08-10 00:00:00',1,0),(600558985,'2015-08-17 00:00:00',1,0);

UNLOCK TABLES;

/*Table structure for table `fondocajafallidas` */

DROP TABLE IF EXISTS `fondocajafallidas`;

CREATE TABLE `fondocajafallidas` (
  `Id` int(11) DEFAULT NULL,
  `Accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fondocajafallidas` */

LOCK TABLES `fondocajafallidas` WRITE;

UNLOCK TABLES;

/*Table structure for table `formaspago` */

DROP TABLE IF EXISTS `formaspago`;

CREATE TABLE `formaspago` (
  `IdFormaPagoFOR` int(11) NOT NULL,
  `DescripcionFOR` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IdFormaPagoFOR`),
  KEY `IdFormaPagoFOR` (`IdFormaPagoFOR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `formaspago` */

LOCK TABLES `formaspago` WRITE;

insert  into `formaspago`(`IdFormaPagoFOR`,`DescripcionFOR`) values (1,'EFECTIVO'),(2,'NARANJA'),(3,'PROVEN'),(4,'CORDOBESA'),(5,'KADICARD'),(6,'VISA'),(7,'VISA ELECTRON'),(8,'MASTERCARD'),(9,'MAESTRO'),(15,'AMERICAN EXPRESS'),(16,'NATIVA'),(99,'TODAS'),(100,'MONTON');

UNLOCK TABLES;

/*Table structure for table `locales` */

DROP TABLE IF EXISTS `locales`;

CREATE TABLE `locales` (
  `IdLocalLOC` int(11) NOT NULL AUTO_INCREMENT,
  `NombreLOC` varchar(50) DEFAULT NULL,
  `DireccionLOC` varchar(50) DEFAULT NULL,
  `TelefonoLOC` varchar(50) DEFAULT NULL,
  `ActivoWebLOC` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`IdLocalLOC`),
  UNIQUE KEY `NombreLOC` (`NombreLOC`),
  KEY `IdLocalLOC` (`IdLocalLOC`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Data for the table `locales` */

LOCK TABLES `locales` WRITE;

insert  into `locales`(`IdLocalLOC`,`NombreLOC`,`DireccionLOC`,`TelefonoLOC`,`ActivoWebLOC`) values (1,'ENTRADAS',NULL,NULL,0),(2,'SALIDAS',NULL,NULL,0),(13,'JESUS MARIA',NULL,NULL,1),(14,'MAKRO',NULL,NULL,1);

UNLOCK TABLES;

/*Table structure for table `pc` */

DROP TABLE IF EXISTS `pc`;

CREATE TABLE `pc` (
  `IdPC` int(11) NOT NULL,
  `IdLocalPC` int(11) DEFAULT NULL,
  `Detalle` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IdPC`),
  KEY `IdLocalPC` (`IdLocalPC`),
  KEY `IdPC` (`IdPC`),
  CONSTRAINT `FK_Pc` FOREIGN KEY (`IdLocalPC`) REFERENCES `locales` (`IdLocalLOC`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pc` */

LOCK TABLES `pc` WRITE;

insert  into `pc`(`IdPC`,`IdLocalPC`,`Detalle`) values (1,13,'Caja1'),(2,13,'Administracion'),(3,14,'Caja1'),(4,14,'Adminstracion');

UNLOCK TABLES;

/*Table structure for table `razonsocial` */

DROP TABLE IF EXISTS `razonsocial`;

CREATE TABLE `razonsocial` (
  `IdRazonSocialRAZ` tinyint(2) NOT NULL,
  `RazonSocialRAZ` varchar(50) DEFAULT NULL,
  `NombreFantasiaRAZ` varchar(50) DEFAULT NULL,
  `DomicilioRAZ` varchar(50) DEFAULT NULL,
  `LocalidadRAZ` varchar(50) DEFAULT NULL,
  `ProvinciaRAZ` varchar(50) DEFAULT NULL,
  `IdCondicionIvaRAZ` tinyint(2) DEFAULT NULL,
  `CuitRAZ` varchar(15) DEFAULT NULL,
  `IngresosBrutosRAZ` varchar(15) DEFAULT NULL,
  `InicioActividadRAZ` datetime DEFAULT NULL,
  `PuntoVentaRAZ` varchar(4) DEFAULT NULL,
  `CorreoRAZ` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IdRazonSocialRAZ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `razonsocial` */

LOCK TABLES `razonsocial` WRITE;

insert  into `razonsocial`(`IdRazonSocialRAZ`,`RazonSocialRAZ`,`NombreFantasiaRAZ`,`DomicilioRAZ`,`LocalidadRAZ`,`ProvinciaRAZ`,`IdCondicionIvaRAZ`,`CuitRAZ`,`IngresosBrutosRAZ`,`InicioActividadRAZ`,`PuntoVentaRAZ`,`CorreoRAZ`) values (1,'Navarro Carolina del Valle','KARMINNA','TUCUMAN 481','JESUS MARIA','CORDOBA',2,'27220379588','270598927','2013-10-01 00:00:00','0001','benjamin_otero@outlook.com');

UNLOCK TABLES;

/*Table structure for table `tesoreriamovimientos` */

DROP TABLE IF EXISTS `tesoreriamovimientos`;

CREATE TABLE `tesoreriamovimientos` (
  `IdMovTESM` int(11) NOT NULL,
  `FechaTESM` datetime DEFAULT NULL,
  `IdPcTESM` int(11) DEFAULT NULL,
  `DetalleTESM` varchar(200) DEFAULT NULL,
  `ImporteTESM` double DEFAULT NULL,
  PRIMARY KEY (`IdMovTESM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tesoreriamovimientos` */

LOCK TABLES `tesoreriamovimientos` WRITE;

UNLOCK TABLES;

/*Table structure for table `tesoreriamovimientosfallidas` */

DROP TABLE IF EXISTS `tesoreriamovimientosfallidas`;

CREATE TABLE `tesoreriamovimientosfallidas` (
  `Id` int(11) DEFAULT NULL,
  `Accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tesoreriamovimientosfallidas` */

LOCK TABLES `tesoreriamovimientosfallidas` WRITE;

insert  into `tesoreriamovimientosfallidas`(`Id`,`Accion`) values (3,'Added');

UNLOCK TABLES;

/*Table structure for table `ventas` */

DROP TABLE IF EXISTS `ventas`;

CREATE TABLE `ventas` (
  `IdVentaVEN` int(11) NOT NULL,
  `IdPCVEN` int(11) DEFAULT NULL,
  `FechaVEN` datetime DEFAULT NULL,
  `IdClienteVEN` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdVentaVEN`),
  KEY `FK_Ventas` (`IdClienteVEN`),
  KEY `FK_Ventas_Pc` (`IdPCVEN`),
  CONSTRAINT `FK_Ventas_Pc` FOREIGN KEY (`IdPCVEN`) REFERENCES `pc` (`IdPC`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventas` */

LOCK TABLES `ventas` WRITE;

insert  into `ventas`(`IdVentaVEN`,`IdPCVEN`,`FechaVEN`,`IdClienteVEN`) values (22639453,1,'2015-09-03 13:12:11',1),(73788775,1,'2015-09-03 13:22:34',1970745042),(131817895,1,'2015-08-24 16:09:16',1970745042),(167252656,1,'2015-08-24 15:49:45',1495736341),(199827849,1,'2015-09-03 13:18:30',1970745042),(220024113,1,'2015-08-24 15:42:02',1970745042),(253534829,1,'2015-09-03 13:01:32',1),(314545698,1,'2015-08-22 16:42:56',1),(382313574,1,'2015-09-04 16:27:17',1),(395484093,1,'2015-08-24 15:58:59',1495736341),(500107718,1,'2015-08-24 15:40:28',1495736341),(597652313,1,'2015-08-22 16:37:54',1),(615519011,1,'2015-09-03 11:05:29',1495736341),(615877102,1,'2015-08-24 16:08:43',1),(622383559,1,'2015-08-25 10:20:26',1),(688228702,1,'2015-08-25 12:15:19',1970745042),(702099820,1,'2015-08-24 16:03:22',1495736341),(747732137,1,'2015-09-03 09:02:46',1),(757576147,1,'2015-08-24 14:40:00',1495736341),(803146392,1,'2015-08-24 15:50:47',1970745042),(814561874,1,'2015-08-24 15:44:22',1970745042),(826090091,1,'2015-08-25 12:50:40',1970745042),(830736548,1,'2015-08-24 15:42:36',1970745042),(865525625,1,'2015-09-03 13:21:38',1495736341),(895893766,1,'2015-09-03 13:19:47',1495736341),(954316104,1,'2015-09-05 11:31:53',1),(985012443,1,'2015-09-02 20:51:45',1),(1150869186,1,'2015-08-24 15:54:15',1970745042),(1159328924,1,'2015-08-25 12:14:23',1970745042),(1168072982,1,'2015-09-04 16:09:50',1),(1260092812,1,'2015-08-22 16:02:57',1),(1294064952,1,'2015-08-25 10:29:14',1495736341),(1357811569,1,'2015-08-24 15:53:31',1495736341),(1440506631,1,'2015-08-24 14:27:15',1970745042),(1473277453,1,'2015-09-03 13:13:06',1),(1507635979,1,'2015-08-25 09:45:04',1495736341),(1527076072,1,'2015-09-03 13:45:32',1970745042),(1541622760,1,'2015-08-25 10:17:32',1495736341),(1550591683,1,'2015-08-25 09:48:53',1970745042),(1570494836,1,'2015-08-24 15:48:00',1970745042),(1794020362,1,'2015-09-03 13:20:34',1970745042),(1870537490,1,'2015-08-24 14:58:06',1495736341),(1901652355,1,'2015-08-24 14:55:04',1495736341),(1964920005,1,'2015-09-03 13:23:19',1495736341);

UNLOCK TABLES;

/*Table structure for table `ventasdetalle` */

DROP TABLE IF EXISTS `ventasdetalle`;

CREATE TABLE `ventasdetalle` (
  `IdDVEN` int(11) NOT NULL,
  `IdVentaDVEN` int(11) DEFAULT NULL,
  `IdLocalDVEN` int(3) DEFAULT NULL,
  `IdArticuloDVEN` varchar(50) DEFAULT NULL,
  `DescripcionDVEN` varchar(50) DEFAULT NULL,
  `CantidadDVEN` int(11) DEFAULT NULL,
  `PrecioPublicoDVEN` double DEFAULT NULL,
  `PrecioCostoDVEN` double DEFAULT NULL,
  `PrecioMayorDVEN` double DEFAULT NULL,
  `IdFormaPagoDVEN` int(11) DEFAULT NULL,
  `NroCuponDVEN` int(11) DEFAULT NULL,
  `NroFacturaDVEN` int(11) DEFAULT NULL,
  `IdEmpleadoDVEN` int(11) DEFAULT NULL,
  `LiquidadoDVEN` bit(1) DEFAULT NULL,
  `EsperaDVEN` bit(1) DEFAULT NULL,
  `DevolucionDVEN` smallint(1) DEFAULT NULL,
  PRIMARY KEY (`IdDVEN`),
  KEY `FK_VentasDetalle_Forma` (`IdFormaPagoDVEN`),
  KEY `FK_VentasDetalle` (`IdVentaDVEN`),
  KEY `FK_VentasDetalle_Articulos` (`IdArticuloDVEN`),
  CONSTRAINT `FK_VentasDetalle` FOREIGN KEY (`IdVentaDVEN`) REFERENCES `ventas` (`IdVentaVEN`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventasdetalle` */

LOCK TABLES `ventasdetalle` WRITE;

insert  into `ventasdetalle`(`IdDVEN`,`IdVentaDVEN`,`IdLocalDVEN`,`IdArticuloDVEN`,`DescripcionDVEN`,`CantidadDVEN`,`PrecioPublicoDVEN`,`PrecioCostoDVEN`,`PrecioMayorDVEN`,`IdFormaPagoDVEN`,`NroCuponDVEN`,`NroFacturaDVEN`,`IdEmpleadoDVEN`,`LiquidadoDVEN`,`EsperaDVEN`,`DevolucionDVEN`) values (28374818,615877102,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(100794339,747732137,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(164353139,1159328924,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(172165558,1507635979,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(244249401,954316104,13,'007',NULL,1,100,0,0,1,NULL,NULL,NULL,NULL,NULL,0),(293963093,688228702,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(311099299,895893766,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(312723071,615519011,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(335234914,1440506631,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(342093943,253534829,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(344799793,1168072982,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(348216961,500107718,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(383583144,814561874,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(403104812,314545698,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(413727400,597652313,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(415422326,702099820,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(635408828,1541622760,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(700615118,826090091,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(745200769,1294064952,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(769811469,1150869186,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(813418375,1870537490,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(814634659,622383559,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(817326854,865525625,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(838691315,1570494836,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(957611084,985012443,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(999831102,1260092812,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1014406378,1357811569,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1044635118,199827849,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1061899681,1550591683,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1087524537,757576147,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1093945860,73788775,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1169848835,1901652355,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1215736565,220024113,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1373544654,803146392,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1409033350,167252656,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1420427361,1527076072,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1491662127,22639453,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1567531936,395484093,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1646702290,1473277453,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1701747741,1964920005,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1755187613,382313574,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1793429270,830736548,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1842229846,131817895,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0),(1961780657,1794020362,13,'0260010000',NULL,1,80,55,0,1,NULL,NULL,NULL,NULL,NULL,0);

UNLOCK TABLES;

/*Table structure for table `ventasdetallefallidas` */

DROP TABLE IF EXISTS `ventasdetallefallidas`;

CREATE TABLE `ventasdetallefallidas` (
  `Id` int(11) DEFAULT NULL,
  `IdVenta` int(11) DEFAULT NULL,
  `Accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventasdetallefallidas` */

LOCK TABLES `ventasdetallefallidas` WRITE;

UNLOCK TABLES;

/*Table structure for table `ventasfallidas` */

DROP TABLE IF EXISTS `ventasfallidas`;

CREATE TABLE `ventasfallidas` (
  `Id` int(11) DEFAULT NULL,
  `Accion` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ventasfallidas` */

LOCK TABLES `ventasfallidas` WRITE;

UNLOCK TABLES;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `mantenimiento` */

/*!50106 DROP EVENT IF EXISTS `mantenimiento`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`root`@`localhost` EVENT `mantenimiento` ON SCHEDULE EVERY 1 HOUR STARTS '2014-11-07 00:00:00' ON COMPLETION PRESERVE ENABLE DO CALL	DatosPos_Mantener() */$$
DELIMITER ;

/* Procedure structure for procedure `AlicuotasIva_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `AlicuotasIva_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `AlicuotasIva_Actualizar`(
IN p_id TINYINT(3),
IN p_porcentaje VARCHAR(50)
)
BEGIN
	UPDATE `alicuotasiva`
	SET `PorcentajeALI` = p_porcentaje
	WHERE `IdAlicuotaALI` = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `AlicuotasIva_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `AlicuotasIva_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `AlicuotasIva_Borrar`(IN p_id tinyint)
BEGIN
DELETE
FROM alicuotasiva
WHERE `IdAlicuotaALI` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `AlicuotasIva_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `AlicuotasIva_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `AlicuotasIva_Insertar`(
IN p_id TINYINT(3),
IN p_porcentaje VARCHAR(50)
)
BEGIN
INSERT INTO alicuotasiva(IdAlicuotaALI, PorcentajeALI)
VALUES(p_id, REPLACE(p_porcentaje, ",","."))
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `AlicuotasIva_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `AlicuotasIva_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `AlicuotasIva_Listar`()
BEGIN
		SELECT * FROM alicuotasiva;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `Alterar_Tabla` */

/*!50003 DROP PROCEDURE IF EXISTS  `Alterar_Tabla` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Alterar_Tabla`()
BEGIN
SET FOREIGN_KEY_CHECKS=0;
alter table Ventas 
drop foreign key FK_ventas_clientes
;
ALTER TABLE VentasDetalle
DROP FOREIGN KEY FK_VentasDetalle_Forma, 
DROP FOREIGN KEY FK_ventasdetalle_articulos
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Alterar_Tabla_2` */

/*!50003 DROP PROCEDURE IF EXISTS  `Alterar_Tabla_2` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Alterar_Tabla_2`()
BEGIN
SET FOREIGN_KEY_CHECKS=0;
alter table Ventas 
ADD CONSTRAINT FK_ventas_clientes
FOREIGN KEY (`IdClienteVEN`)
REFERENCES Clientes(IdClienteCLI)
ON DELETE set null
ON UPDATE cascade
;
ALTER TABLE VentasDetalle 
ADD CONSTRAINT FK_VentasDetalle_Forma
FOREIGN KEY (`IdFormaPagoDVEN`)
REFERENCES FormasPago(`IdFormaPagoFOR`)
ON DELETE SET NULL
ON UPDATE CASCADE
;
ALTER TABLE VentasDetalle 
ADD CONSTRAINT FK_ventasdetalle_articulos
FOREIGN KEY (`IdArticuloDVEN`)
REFERENCES Articulos(`IdArticuloART`)
ON DELETE SET NULL
ON UPDATE CASCADE
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulos_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulos_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Articulos_Actualizar`(
IN p_id VARCHAR(50),
IN p_idAlicuota TINYINT(3),
IN p_descripcion VARCHAR(55),
IN p_precioCosto DECIMAL(19),
IN p_precioPublico DECIMAL(19),
IN p_precioMayor DECIMAL(19)
)
BEGIN
update articulos set IdAliculotaIvaART = p_idAlicuota, DescripcionART = p_descripcion,
PrecioCostoART = REPLACE(p_precioCosto, ",","."), PrecioPublicoART = REPLACE(p_precioPublico, ",","."), 
PrecioMayorART = REPLACE(p_precioMayor, ",",".")
where IdArticuloART = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulos_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulos_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Articulos_Borrar`(IN p_id VARCHAR(50))
BEGIN
DELETE
FROM articulos
WHERE IdArticuloART = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulos_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulos_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Articulos_Insertar`(
IN p_id VARCHAR(50),
IN p_idAlicuota TINYINT(3),
IN p_descripcion VARCHAR(55),
IN p_precioCosto DECIMAL(19),
IN p_precioPublico DECIMAL(19),
IN p_precioMayor DECIMAL(19)
)
BEGIN
INSERT INTO Articulos(IdArticuloART, IdAliculotaIvaART, DescripcionART,
PrecioCostoART, PrecioPublicoART, PrecioMayorART)
VALUES(p_id, p_idAlicuota, p_descripcion, REPLACE(p_precioCosto, ",","."), 
REPLACE(p_precioPublico, ",","."), REPLACE(p_precioMayor, ",","."))
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Articulos_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Articulos_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Articulos_Listar`()
BEGIN
select *
FROM Articulos
order by DescripcionART
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_Actualizar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
update clientesfallidas set Accion = p_accion
where Id = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_Borrar`(
in p_id int,
in p_accion varchar(20)
)
BEGIN
DELETE FROM clientes
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_BorrarByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_BorrarByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_BorrarByAccion`(
in p_accion varchar(20)
)
BEGIN
DELETE FROM clientesfallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_BorrarByPK` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_BorrarByPK` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_BorrarByPK`(
in p_id varchar(20)
)
BEGIN
DELETE FROM clientesfallidas
where Id = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_Existe` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_Existe` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_Existe`(
IN p_id int,
in p_accion varchar(20)
)
BEGIN
select * from clientesfallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_Get`()
BEGIN
select * from clientesfallidas
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_GetByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_GetByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_GetByAccion`(
in p_accion varchar(20)
)
BEGIN
select * from clientesfallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ClientesFallidas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `ClientesFallidas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `ClientesFallidas_Insertar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
INSERT INTO clientesfallidas(Id, Accion)
VALUES(p_id, p_accion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Clientes_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Clientes_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Clientes_Actualizar`(
in p_id int(11),
IN p_razon varchar(50),
IN p_cuit VARCHAR(50),
IN p_condicion VARCHAR(50),
IN p_direccion VARCHAR(50),
IN p_localidad VARCHAR(50),
IN p_provincia VARCHAR(50),
IN p_transporte VARCHAR(50),
IN p_contacto VARCHAR(50),
IN p_telefono VARCHAR(50),
IN p_movil VARCHAR(50),
IN p_correo VARCHAR(50)
)
BEGIN
update Clientes set RazonSocialCLI = p_razon, CUIT = p_cuit, CondicionIvaCLI = p_condicion, DireccionCLI = p_direccion,  
LocalidadCLI = p_localidad, ProvinciaCLI = p_provincia, TransporteCLI = p_transporte,
ContactoCLI = p_contacto, TelefonoCLI = p_telefono, MovilCLI = p_movil, CorreoCLI = p_correo
where IdClienteCLI = p_id 
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Clientes_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Clientes_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Clientes_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM Clientes
WHERE IdClienteCLI = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Clientes_GetByPk` */

/*!50003 DROP PROCEDURE IF EXISTS  `Clientes_GetByPk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Clientes_GetByPk`(
in p_id int
)
BEGIN
select * from clientes where `IdClienteCLI` = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Clientes_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Clientes_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Clientes_Insertar`(
IN p_id INT(11),
IN p_razon VARCHAR(50),
IN p_cuit VARCHAR(50),
IN p_condicion VARCHAR(50),
IN p_direccion VARCHAR(50),
IN p_localidad VARCHAR(50),
IN p_provincia VARCHAR(50),
IN p_transporte VARCHAR(50),
IN p_contacto VARCHAR(50),
IN p_telefono VARCHAR(50),
IN p_movil VARCHAR(50),
IN p_correo VARCHAR(50)
)
BEGIN
INSERT INTO Clientes(IdClienteCLI, RazonSocialCLI, CUIT, CondicionIvaCLI, DireccionCLI, LocalidadCLI, ProvinciaCLI,
TransporteCLI, ContactoCLI, TelefonoCLI, MovilCLI, CorreoCLI)
VALUES(p_id, p_razon, p_cuit, p_condicion, p_direccion, p_localidad, p_provincia, p_transporte, p_contacto,
p_telefono, p_movil, p_correo)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Clientes_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Clientes_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Clientes_Listar`()
BEGIN
select *
FROM clientescons
order by RazonSocialCLI
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Colores_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Colores_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Colores_Actualizar`(
IN p_id INT(11),
IN p_descripcion VARCHAR(50),
IN p_hex VARCHAR(50)
)
BEGIN
UPDATE Colores SET DescripcionCOL = p_descripcion, HexCOL = p_hex
WHERE IdColorCOL = p_id 
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Colores_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Colores_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Colores_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM Colores
WHERE IdColorCOL= p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Colores_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Colores_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Colores_Insertar`(
IN p_id INT,
IN p_descripcion VARCHAR(50),
IN p_hex VARCHAR(50)
)
BEGIN
INSERT INTO Colores(IdColorCOL, DescripcionCOL, HexCOL)
VALUES(p_id, p_descripcion, p_hex)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Colores_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Colores_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Colores_Listar`()
BEGIN
select *
FROM Colores
order by DescripcionCOL
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CondicionIva_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `CondicionIva_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `CondicionIva_Actualizar`(
in p_id tinyint(2),
IN p_descripcion varchar(50))
BEGIN
	UPDATE `condicioniva`
	SET `DescripcionCIVA` = p_descripcion
	WHERE `IdCondicionIvaCIVA` = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CondicionIva_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `CondicionIva_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `CondicionIva_Borrar`(IN p_id tinyint)
BEGIN
DELETE
FROM condicioniva
WHERE `IdCondicionIvaCIVA` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CondicionIva_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `CondicionIva_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `CondicionIva_Insertar`(
in p_id tinyint(2),
IN p_descripcion VARCHAR(50)
)
BEGIN
INSERT INTO condicioniva(IdCondicionIvaCIVA, DescripcionCIVA)
VALUES(p_id, p_descripcion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CondicionIva_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `CondicionIva_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `CondicionIva_Listar`()
BEGIN
		SELECT * FROM condicioniva;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DatosPos_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `DatosPos_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `DatosPos_Borrar`(
p_existe tinyint)
BEGIN
DELETE FROM Articulos;
if p_existe = 0 then
	DELETE FROM Clientes;
end if;	
DELETE FROM FormasPago;
delete from alicuotasiva;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DatosPos_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `DatosPos_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `DatosPos_Listar`()
BEGIN
SELECT * FROM articuloscons;
SELECT * FROM clientescons;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DatosPos_Mantener` */

/*!50003 DROP PROCEDURE IF EXISTS  `DatosPos_Mantener` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `DatosPos_Mantener`()
BEGIN
DELETE FROM `fondocaja` WHERE `FechaFONP` < DATE_SUB(CURDATE(), INTERVAL 90 DAY);
DELETE FROM `tesoreriamovimientos` WHERE `FechaTESM` < DATE_SUB(CURDATE(), INTERVAL 90 DAY);
DELETE FROM ventas WHERE FechaVEN < DATE_SUB(CURDATE(), INTERVAL 90 DAY);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Fallidas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Fallidas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Fallidas_Borrar`(
IN p_descripcion varchar(20),
in p_accion varchar(20)
)
BEGIN
DELETE
FROM Fallidas
where DescripcionFLL = p_descripcion and AccionFLL = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Fallidas_GetByPK` */

/*!50003 DROP PROCEDURE IF EXISTS  `Fallidas_GetByPK` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Fallidas_GetByPK`(IN p_id INT)
BEGIN
select *
FROM Fallidas
WHERE `Id` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Fallidas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Fallidas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Fallidas_Insertar`(
IN p_id int(10),
IN p_descripcion VARCHAR(20),
in p_accion varchar(20)
)
BEGIN
INSERT INTO Fallidas(Id, DescripcionFLL, AccionFLL)
VALUES(p_id, p_descripcion, p_accion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Fallidas_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Fallidas_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Fallidas_Listar`(
in p_descripcion varchar(20),
IN p_accion VARCHAR(20)
)
BEGIN
select * from Fallidas
where DescripcionFLL = p_descripcion and AccionFLL = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCajaFallidas_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCajaFallidas_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCajaFallidas_Actualizar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
update FondoCajaFallidas set Accion = p_accion
where Id = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCajaFallidas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCajaFallidas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCajaFallidas_Borrar`(
in p_id int,
in p_accion varchar(20)
)
BEGIN
DELETE FROM FondoCajaFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCajaFallidas_BorrarByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCajaFallidas_BorrarByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCajaFallidas_BorrarByAccion`(
in p_accion varchar(20)
)
BEGIN
DELETE FROM FondoCajaFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCajaFallidas_Existe` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCajaFallidas_Existe` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCajaFallidas_Existe`(
IN p_id int,
in p_accion varchar(20)
)
BEGIN
select * from FondoCajaFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCajaFallidas_GetByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCajaFallidas_GetByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCajaFallidas_GetByAccion`(
in p_accion varchar(20)
)
BEGIN
select * from FondoCajaFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCajaFallidas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCajaFallidas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCajaFallidas_Insertar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
INSERT INTO FondoCajaFallidas(Id, Accion)
VALUES(p_id, p_accion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Actualizar`(
in p_id int,
in p_fecha VARCHAR(50),
IN p_pc int(11),
in p_importe double
)
BEGIN
update FondoCaja set `IdFondoFONP` = p_id, `FechaFONP` = p_fecha, `IdPcFONP` = p_pc, `ImporteFONP` = p_importe
where `IdFondoFONP` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Actualizar2` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Actualizar2` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Actualizar2`(
in p_id int,
in p_fecha VARCHAR(50),
IN p_pc int(11),
in p_importe double
)
BEGIN
update FondoCaja set `IdFondoFONP` = p_id, `FechaFONP` = p_fecha, `IdPcFONP` = p_pc, `ImporteFONP` = p_importe
where `IdFondoFONP` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Borrar`(
IN p_fecha varchar(50),
IN p_pc INT(11)
)
BEGIN
DELETE
FROM FondoCaja
WHERE `FechaFONP` = p_fecha and `IdPcFONP` = p_pc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_GetByPk` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_GetByPk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_GetByPk`(
in p_id int
)
BEGIN
select * from FondoCaja where IdFondoFONP = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Inicial` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Inicial` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Inicial`(
in p_fecha varchar(50),
in p_idPc int(11)
)
BEGIN
SELECT `ImporteFONP` FROM FondoCaja
WHERE `FechaFONP` = (SELECT MAX(`FechaFONP`) FROM FondoCaja WHERE `FechaFONP` < p_fecha)
AND `IdPcFONP` = p_idPc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Inicial_Final` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Inicial_Final` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Inicial_Final`(
in p_fecha varchar(50),
in p_idPc int(11)
)
BEGIN
SELECT `ImporteFONP` FROM FondoCaja
WHERE `FechaFONP` = (SELECT MAX(`FechaFONP`) FROM FondoCaja WHERE `FechaFONP` < p_fecha)
AND `IdPcFONP` = p_idPc
;
SELECT * FROM FondoCaja
WHERE `FechaFONP` = p_fecha
AND `IdPcFONP` = p_idPc
;
SELECT * FROM `TesoreriaMovimientos`
WHERE `FechaTESM` = p_fecha
AND `IdPcTESM` = p_idPc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Insertar`(
in p_id int,
IN p_fecha DATETIME,
IN p_pc INT(11),
IN p_importe DOUBLE
)
BEGIN
INSERT INTO FondoCaja(`IdFondoFONP`, `FechaFONP`, `IdPcFONP`, `ImporteFONP`)
VALUES(p_id, p_fecha, p_pc, p_importe)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Insertar2` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Insertar2` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Insertar2`(
IN p_id INT,
IN p_fecha DATETIME,
IN p_pc INT(11),
IN p_importe DOUBLE
)
BEGIN
INSERT INTO FondoCaja(`IdFondoFONP`, `FechaFONP`, `IdPcFONP`, `ImporteFONP`)
VALUES(p_id, p_fecha, p_pc, p_importe)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_Listar`()
BEGIN
SELECT *
FROM FondoCaja
where FechaFONP = '1900-01-01'
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_ListarCons` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_ListarCons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_ListarCons`()
BEGIN
SELECT *
FROM FondoCajaCons
order by `FechaFONP` desc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FondoCaja_PK` */

/*!50003 DROP PROCEDURE IF EXISTS  `FondoCaja_PK` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FondoCaja_PK`(
IN p_fecha DATETIME,
IN p_pc INT(11)
)
BEGIN
SELECT *
FROM FondoCaja
WHERE `FechaFONP` = p_fecha and `IdPcFONP` = p_pc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FormasPago_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FormasPago_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FormasPago_Actualizar`(
in p_id int(11),
IN p_descripcion varchar(50))
BEGIN
update FormasPago set DescripcionFOR = p_descripcion
where IdFormaPagoFOR = p_id 
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FormasPago_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FormasPago_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FormasPago_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM FormasPago
WHERE IdFormaPagoFOR= p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FormasPago_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FormasPago_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FormasPago_Insertar`(
in p_id int(11),
IN p_descripcion VARCHAR(50)
)
BEGIN
INSERT INTO FormasPago(IdFormaPagoFOR, DescripcionFOR)
VALUES(p_id, p_descripcion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `FormasPago_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `FormasPago_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `FormasPago_Listar`()
BEGIN
select *
FROM FormasPago
order by DescripcionFOR
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Locales_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Locales_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Locales_Listar`()
BEGIN
select *
FROM Locales
order by IdLocalLOC
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Pcs_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Pcs_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Pcs_Listar`()
BEGIN
select *
FROM Pc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `PedidoCons` */

/*!50003 DROP PROCEDURE IF EXISTS  `PedidoCons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `PedidoCons`(
in p_fechaDesde varchar(50)
)
BEGIN
drop table if exists PedidoVentas;
CREATE TABLE PedidoVentas
AS SELECT
	`VentasDetalle`.`IdArticuloDVEN`
    , SUM(`VentasDetalle`.`CantidadDVEN`) as Venta
FROM
    `ncsoftwa_re`.`VentasDetalle`
    INNER JOIN `ncsoftwa_re`.`Ventas` 
        ON (`VentasDetalle`.`IdVentaDVEN` = `Ventas`.`IdVentaVEN`)
WHERE FechaVEN >=p_fechaDesde         
GROUP BY `VentasDetalle`.`IdArticuloDVEN`;
SELECT
	`PedidoStockCons`.`RazonSocialPRO` as Proveedor
	, `PedidoStockCons`.`IdArticuloSTK` as Articulo
	, `PedidoStockCons`.`DescripcionART` AS Descripcion
	, `PedidoVentas`.`Venta`
	, `PedidoStockCons`.`Stock`
	, `PedidoStockCons`.`Costo`
	, `PedidoStockCons`.`Publico`
FROM
    `ncsoftwa_re`.`PedidoVentas`
    RIGHT JOIN `ncsoftwa_re`.`PedidoStockCons` 
        ON (`PedidoVentas`.`IdArticuloDVEN` = `PedidoStockCons`.`IdArticuloSTK`)
    order by `PedidoStockCons`.`DescripcionART`    
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `PedidoCons2` */

/*!50003 DROP PROCEDURE IF EXISTS  `PedidoCons2` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `PedidoCons2`(
in p_fechaDesde varchar(50)
)
BEGIN
drop table if exists PedidoVentas;
CREATE TABLE PedidoVentas
AS SELECT
	`VentasDetalle`.`IdArticuloDVEN`
    , SUM(`VentasDetalle`.`CantidadDVEN`) as Venta
FROM
    `ncsoftwa_karminna`.`VentasDetalle`
    INNER JOIN `ncsoftwa_karminna`.`Ventas` 
        ON (`VentasDetalle`.`IdVentaDVEN` = `Ventas`.`IdVentaVEN`)
WHERE FechaVEN >=p_fechaDesde         
GROUP BY `VentasDetalle`.`IdArticuloDVEN`;
SELECT
	`PedidoStockCons`.`RazonSocialPRO` as Proveedor
	, `PedidoStockCons`.`IdArticuloSTK` as Articulo
	, `PedidoVentas`.`Venta`
	, `PedidoStockCons`.`Stock`
	, `PedidoStockCons`.`Costo`
	, `PedidoStockCons`.`Publico`
FROM
    `ncsoftwa_karminna`.`PedidoVentas`
    RIGHT JOIN `ncsoftwa_karminna`.`PedidoStockCons` 
        ON (`PedidoVentas`.`IdArticuloDVEN` = `PedidoStockCons`.`IdArticuloSTK`);
END */$$
DELIMITER ;

/* Procedure structure for procedure `Probando` */

/*!50003 DROP PROCEDURE IF EXISTS  `Probando` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Probando`(
in p_locales varchar(200),
in p_forma int(2),
in p_fechaDesde varchar(50),
IN p_fechaHasta VARCHAR(50)
)
BEGIN
  DECLARE locales VARCHAR(50);
  DECLARE forma INT(2);
  DECLARE fechaDesde VARCHAR(50);
  DECLARE fechaHasta VARCHAR(50);
  SET locales = p_locales;
  SET forma = p_forma;
  SET fechaDesde = p_fechaDesde;
  SET fechaHasta = p_fechaHasta;
  
  SET @QUERY = CONCAT("SELECT 
	NombreLOC, SUM(Venta) AS Venta, SUM(Costo) AS Costo, SUM(Prendas) AS Prendas, 
	(SUM(Venta) - SUM(Costo)) AS 'Utilidad bruta', ((SUM(Venta)/SUM(Costo))-1) AS 'Valor agregado'
	FROM VentasPesosCons 
	WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <='",fechaHasta,"')
	GROUP BY NombreLOC");
  
  PREPARE smpt FROM @QUERY;
  EXECUTE smpt;
  
END */$$
DELIMITER ;

/* Procedure structure for procedure `Probando_Ejecutar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Probando_Ejecutar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Probando_Ejecutar`()
BEGIN
  declare locales varchar(50);
  DECLARE forma int(2);
  DECLARE fechaDesde varchar(50);
  DECLARE fechaHasta VARCHAR(50);
  SET locales = 'IdLocalLOC =14 OR IdLocalLOC =13' ;
  SET forma = 1 ;
  SET fechaDesde = '2013-12-26 00:00:00' ;
  SET fechaHasta = '2013-12-29 00:00:00' ;
  
call Probando(locales, forma, fechaDesde);
  
END */$$
DELIMITER ;

/* Procedure structure for procedure `Proveedores_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Proveedores_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Proveedores_Actualizar`(
in p_id int(11),
IN p_razon varchar(50),
IN p_direccion VARCHAR(50),
IN p_codigo VARCHAR(50),
IN p_telefono VARCHAR(50),
IN p_contacto VARCHAR(50)
)
BEGIN
update Proveedores set RazonSocialPRO = p_razon, DireccionPRO = p_direccion, CodigoPostalPRO = p_codigo,
TelefonoPRO = p_telefono, ContactoPRO = p_contacto
where IdProveedorPRO = p_id 
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Proveedores_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Proveedores_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Proveedores_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM Proveedores
WHERE IdProveedorPRO = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Proveedores_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Proveedores_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Proveedores_Insertar`(
IN p_id int,
IN p_razon VARCHAR(50),
IN p_direccion VARCHAR(50),
IN p_codigo VARCHAR(50),
IN p_telefono VARCHAR(50),
IN p_contacto VARCHAR(50)
)
BEGIN
INSERT INTO Proveedores(IdProveedorPRO, RazonSocialPRO, DireccionPRO , CodigoPostalPRO, TelefonoPRO, ContactoPRO)
VALUES(p_id, p_razon, p_direccion, p_codigo, p_telefono, p_contacto)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Proveedores_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Proveedores_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Proveedores_Listar`()
BEGIN
select *
FROM Proveedores
order by RazonSocialPRO
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `RazonSocial_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `RazonSocial_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `RazonSocial_Actualizar`(
p_id tinyint(2),
p_razon varchar(50),
p_nombre VARCHAR(50),
p_domicilio VARCHAR(50),
p_localidad VARCHAR(50),
p_provincia VARCHAR(50),
p_idCondicionIva TINYINT(2),
p_cuit varchar(15),
p_ingresosB VARCHAR(15),
p_inicio datetime,
p_punto varchar(4),
p_correo VARCHAR(50)
)
BEGIN
UPDATE `razonsocial`
SET `RazonSocialRAZ` = p_razon,
  `NombreFantasiaRAZ` = p_nombre,
  `DomicilioRAZ` = p_domicilio,
  `LocalidadRAZ` = p_localidad,
  `ProvinciaRAZ` = p_provincia,
  `IdCondicionIvaRAZ` = p_idCondicionIva,
  `CuitRAZ` = p_cuit,
  `IngresosBrutosRAZ` = p_ingresosB,
  `InicioActividadRAZ` = p_inicio,
  `PuntoVentaRAZ` = p_punto,
  `CorreoRAZ` = p_correo
WHERE `IdRazonSocialRAZ` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `RazonSocial_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `RazonSocial_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `RazonSocial_Borrar`(
IN p_id TINYINT(2)
)
BEGIN
delete from `razonsocial`
where IdRazonSocialRAZ = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `RazonSocial_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `RazonSocial_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `RazonSocial_Listar`()
BEGIN
select * from `razonsocialcons`
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMovDetalle_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMovDetalle_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMovDetalle_Actualizar`(
in p_id_detalle int,
in p_articulo varchar(50),
in p_cantidad int,
in p_compensa tinyint
)
BEGIN
UPDATE StockMovDetalle SET IdArticuloMSTKD = p_articulo, CantidadMSTKD = p_cantidad, CompensaMSTKD = p_compensa
WHERE IdMSTKD = p_id_detalle
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMovDetalle_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMovDetalle_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMovDetalle_Borrar`(IN p_id_detalle INT)
BEGIN
DELETE
FROM StockMovDetalle
WHERE IdMSTKD= p_id_detalle
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMovDetalle_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMovDetalle_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMovDetalle_Insertar`(
IN p_id_detalle INT,
IN p_id_mov INT,
IN p_articulo VARCHAR(50),
IN p_cantidad INT,
IN p_compensa TINYINT,
IN p_origen TINYINT,
IN p_destino TINYINT
)
BEGIN
INSERT INTO StockMovDetalle(IdMSTKD, IdMovMSTKD, IdArticuloMSTKD, CantidadMSTKD, CompensaMSTKD,
OrigenMSTKD, DestinoMSTKD)
VALUES(p_id_detalle, p_id_mov, p_articulo, p_cantidad, p_compensa, p_origen, p_destino)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMov_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMov_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMov_Actualizar`(
in p_id int,
IN p_fecha datetime,
in p_origen int,
in p_destino int,
IN p_compensa TINYINT
)
BEGIN
update StockMov set FechaMSTK = p_fecha, OrigenMSTK = p_origen, DestinoMSTK = p_destino, CompensaMSTK = p_compensa
where IdMovMSTK = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMov_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMov_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMov_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM StockMov
WHERE IdMovMSTK= p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMov_Cons` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMov_Cons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMov_Cons`(
in p_fecha_desde varchar(50),
IN p_fecha_hasta VARCHAR(50),
in p_id_local int(3),
in p_tipo_mov varchar(15),
in p_movimiento varchar(8)
)
BEGIN
IF p_tipo_mov ='movimientos' THEN
	IF p_movimiento ='entradas' THEN
		select * from StockMov
		WHERE (`FechaMSTK` >= p_fecha_desde and `FechaMSTK` <= p_fecha_hasta) 
		and `DestinoMSTK` = p_id_local and `CompensaMSTK` = 0
		order by FechaMSTK;
		
		select * from StockMovCons
		WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
		AND `DestinoMSTK` = p_id_local AND `CompensaMSTK` = 0
		order by DescripcionART;
	elseif p_movimiento ='salidas' THEN
		SELECT * FROM StockMov
		WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
		AND `OrigenMSTK` = p_id_local AND `CompensaMSTK` = 0
		ORDER BY FechaMSTK;
		
		SELECT * FROM StockMovCons
		WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
		AND `OrigenMSTK` = p_id_local AND `CompensaMSTK` = 0
		ORDER BY DescripcionART;
	else
		SELECT * FROM StockMov
		WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
		AND (`OrigenMSTK` = p_id_local OR `DestinoMSTK` = p_id_local) AND `CompensaMSTK` = 0
		ORDER BY FechaMSTK;
		
		SELECT * FROM StockMovCons
		WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
		AND (`OrigenMSTK` = p_id_local OR `DestinoMSTK` = p_id_local) AND `CompensaMSTK` = 0
		ORDER BY DescripcionART;	
	end if;
else
	SELECT * FROM StockMov
	WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
	AND `DestinoMSTK` = p_id_local AND `CompensaMSTK` = 1
	ORDER BY FechaMSTK;
	
	SELECT * FROM StockMovCons
	WHERE (`FechaMSTK` >= p_fecha_desde AND `FechaMSTK` <= p_fecha_hasta) 
	AND `DestinoMSTK` = p_id_local AND `CompensaMSTK` = 1
	ORDER BY DescripcionART;
end if;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMov_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMov_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMov_Insertar`(
in p_id int,
IN p_fecha datetime,
in p_origen int,
in p_destino int,
IN p_compensa tinyint
)
BEGIN
INSERT INTO StockMov(IdMovMSTK, FechaMSTK, OrigenMSTK, DestinoMSTK, CompensaMSTK)
VALUES(p_id, p_fecha, p_origen, p_destino, p_compensa)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `StockMov_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `StockMov_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `StockMov_Listar`(
)
BEGIN
select * from StockMov;
select * from StockMovDetalle;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Stock_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Stock_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Stock_Actualizar`(
in p_id_articulo varchar(50),
IN p_id_local int,
in p_cantidad int
)
BEGIN
update Stock set CantidadSTK = p_cantidad
where IdArticuloSTK = p_id_articulo and IdLocalSTK = p_id_local
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Stock_Cons` */

/*!50003 DROP PROCEDURE IF EXISTS  `Stock_Cons` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Stock_Cons`(
IN p_locales VARCHAR(200),
IN p_proveedor INT(3),
IN p_articulo VARCHAR(9),
IN p_descripcion VARCHAR(200),
in p_activoWeb int(1)
)
BEGIN
	IF p_proveedor<>0 THEN
		if p_activoWeb = 0 then
			SET @QUERY = CONCAT("SELECT Articulo, Descripcion, Cantidad, Proveedor, NombreLOC FROM StockCons 
			WHERE ((",p_locales,") AND IdProveedorPRO ='",p_proveedor,"') AND (Articulo LIKE '",p_articulo,"%'
				AND Descripcion LIKE '%",p_descripcion,"%')
			ORDER BY Descripcion");	
		else
			SET @QUERY = CONCAT("SELECT Articulo, Descripcion, Cantidad, Proveedor, NombreLOC FROM StockCons 
			WHERE ((",p_locales,") AND IdProveedorPRO ='",p_proveedor,"') AND (Articulo LIKE '",p_articulo,"%'
				AND Descripcion LIKE '%",p_descripcion,"%' AND ActivoWebART = 1 AND ImagenART<>'')
			ORDER BY Descripcion");			
		end if;
	ELSE
		IF p_activoWeb = 0 THEN
			SET @QUERY = CONCAT("SELECT Articulo, Descripcion, Cantidad, Proveedor, NombreLOC FROM StockCons 
			WHERE ((",p_locales,") AND (Articulo LIKE '",p_articulo,"%'
				AND Descripcion LIKE '%",p_descripcion,"%'))
			ORDER BY Descripcion");
		ELSE
			SET @QUERY = CONCAT("SELECT Articulo, Descripcion, Cantidad, Proveedor, NombreLOC FROM StockCons 
			WHERE ((",p_locales,") AND (Articulo LIKE '",p_articulo,"%'
				AND Descripcion LIKE '%",p_descripcion,"%' AND ActivoWebART = 1 AND ImagenART<>''))
			ORDER BY Descripcion");		
		END IF;
	END IF;
  
  PREPARE smpt FROM @QUERY;
  EXECUTE smpt;
  
END */$$
DELIMITER ;

/* Procedure structure for procedure `Stock_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Stock_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Stock_Insertar`(
in p_id_articulo varchar(50),
in p_id_local int,
IN p_cantidad int
)
BEGIN
INSERT INTO Stock(IdArticuloSTK, IdLocalSTK, CantidadSTK)
VALUES(p_id_articulo, p_id_local, p_cantidad)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Stock_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Stock_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Stock_Listar`(
)
BEGIN
select *
FROM Stock
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Stock_WhereLocal` */

/*!50003 DROP PROCEDURE IF EXISTS  `Stock_WhereLocal` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Stock_WhereLocal`(
in p_locales varchar(100)
)
BEGIN
select *
FROM Stock
p_locales
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovFechaLocal_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovFechaLocal_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovFechaLocal_Listar`(
in p_fecha datetime,
in p_pc int(11)
)
BEGIN
select *
FROM TesoreriaMovimientos
where `FechaTESM` = p_fecha and `IdPcTESM` = p_pc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientosFallidas_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientosFallidas_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientosFallidas_Actualizar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
update TesoreriaMovimientosFallidas set Accion = p_accion
where Id = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientosFallidas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientosFallidas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientosFallidas_Borrar`(
in p_id int,
in p_accion varchar(20)
)
BEGIN
DELETE FROM TesoreriaMovimientosFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientosFallidas_BorrarByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientosFallidas_BorrarByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientosFallidas_BorrarByAccion`(
in p_accion varchar(20)
)
BEGIN
DELETE FROM TesoreriaMovimientosFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientosFallidas_Existe` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientosFallidas_Existe` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientosFallidas_Existe`(
IN p_id int,
in p_accion varchar(20)
)
BEGIN
select * from TesoreriaMovimientosFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientosFallidas_GetByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientosFallidas_GetByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientosFallidas_GetByAccion`(
in p_accion varchar(20)
)
BEGIN
select * from TesoreriaMovimientosFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientosFallidas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientosFallidas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientosFallidas_Insertar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
INSERT INTO TesoreriaMovimientosFallidas(Id, Accion)
VALUES(p_id, p_accion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMovimientos_GetByPk` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMovimientos_GetByPk` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMovimientos_GetByPk`(
in p_id int
)
BEGIN
select * from TesoreriaMovimientos where `IdMovTESM` = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMov_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMov_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMov_Actualizar`(
in p_id int(11),
in p_fecha datetime,
IN p_pc int(11),
IN p_detalle varchar(50),
in p_importe double
)
BEGIN
update TesoreriaMovimientos set `FechaTESM` = p_fecha, `IdPcTESM` = p_pc, 
`DetalleTESM` = p_detalle, `ImporteTESM` = p_importe
where `IdMovTESM` = p_id 
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMov_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMov_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMov_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM TesoreriaMovimientos
WHERE `IdMovTESM` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMov_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMov_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMov_Insertar`(
IN p_id INT(11),
IN p_fecha DATETIME,
IN p_pc INT(11),
IN p_detalle VARCHAR(50),
IN p_importe DOUBLE
)
BEGIN
INSERT INTO TesoreriaMovimientos(`IdMovTESM`, `FechaTESM`, `IdPcTESM`, `DetalleTESM`, `ImporteTESM`)
VALUES(p_id, p_fecha, p_pc, p_detalle, p_importe)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `TesoreriaMov_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `TesoreriaMov_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `TesoreriaMov_Listar`()
BEGIN
select *
FROM TesoreriaMovimientos
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleCons_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleCons_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleCons_Listar`(
in p_locales varchar(200),
in p_forma int(2),
in p_fechaDesde varchar(50),
IN p_fechaHasta VARCHAR(50),
in p_opcion int(1),
in p_parametros varchar(200)
)
BEGIN
  DECLARE locales VARCHAR(50);
  DECLARE forma INT(2);
  DECLARE fechaDesde VARCHAR(50);
  DECLARE fechaHasta VARCHAR(50);
  DECLARE opcion int(1);
  DECLARE parametros VARCHAR(200);
  SET locales = p_locales;
  SET forma = p_forma;
  SET fechaDesde = p_fechaDesde;
  SET fechaHasta = p_fechaHasta;
  set opcion = p_opcion;
  set parametros = p_parametros;
  
if forma =99 then	
	if opcion = 1 then 	
		SET @QUERY = CONCAT("SELECT 
		NombreLOC AS Local, FechaVEN AS Fecha, IdArticuloDVEN AS Artículo, DescripcionART AS Descripción, 
		CantidadDVEN AS Cantidad, PrecioPublicoDVEN AS Precio, DescripcionFOR AS 'Forma de pago'
		FROM VentasDetalleCons 
		WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <='",fechaHasta,"') 
		AND IdArticuloDVEN LIKE '",parametros,"%'");
	else
		
		SET @QUERY = CONCAT("SELECT 
		NombreLOC AS Local, FechaVEN AS Fecha, IdArticuloDVEN AS Artículo, DescripcionART AS Descripción, 
		CantidadDVEN AS Cantidad, PrecioPublicoDVEN AS Precio, DescripcionFOR AS 'Forma de pago'
		FROM VentasDetalleCons 
		WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <='",fechaHasta,"') 
		AND DescripcionART LIKE '%",parametros,"%'");
	end if;
else
	IF opcion = 1 THEN 	
		SET @QUERY = CONCAT("SELECT 
		NombreLOC AS Local, FechaVEN AS Fecha, IdArticuloDVEN AS Artículo, DescripcionART AS Descripción, 
		CantidadDVEN AS Cantidad, PrecioPublicoDVEN AS Precio, DescripcionFOR AS 'Forma de pago'
		FROM VentasDetalleCons 
		WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <='",fechaHasta,"') 
		AND IdArticuloDVEN LIKE '",parametros,"%' AND IdFormaPagoFOR =",p_forma);
	ELSE
		
		SET @QUERY = CONCAT("SELECT 
		NombreLOC AS Local, FechaVEN AS Fecha, IdArticuloDVEN AS Artículo, DescripcionART AS Descripción, 
		CantidadDVEN AS Cantidad, PrecioPublicoDVEN AS Precio, DescripcionFOR AS 'Forma de pago'
		FROM VentasDetalleCons 
		WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <='",fechaHasta,"') 
		AND DescripcionART LIKE '%",parametros,"%' AND IdFormaPagoFOR =",p_forma);
	END IF;	
END IF;
  
  PREPARE smpt FROM @QUERY;
  EXECUTE smpt;
  
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_Borrar`(
in p_id int,
in p_accion varchar(20)
)
BEGIN
DELETE FROM VentasDetalleFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_BorrarByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_BorrarByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_BorrarByAccion`(
in p_accion varchar(20)
)
BEGIN
DELETE FROM VentasDetalleFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_BorrarCopia` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_BorrarCopia` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_BorrarCopia`()
BEGIN
DELETE
FROM VentasDetalleFallidas
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_DelByVenta` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_DelByVenta` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_DelByVenta`(
in p_id_venta int
)
BEGIN
DELETE FROM VentasDetalleFallidas
where IdVenta = p_id_venta
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_Existe` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_Existe` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_Existe`(
IN p_id int,
in p_accion varchar(20)
)
BEGIN
select * from VentasDetalleFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_Get`(
in p_accion varchar(20)
)
BEGIN
select * from VentasDetalleFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_GetByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_GetByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_GetByAccion`(
in p_accion varchar(20)
)
BEGIN
select * from VentasDetalleFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_Insertar`(
IN p_id int(10),
IN p_id_venta INT(10),
in p_accion varchar(20)
)
BEGIN
INSERT INTO VentasDetalleFallidas(Id, IdVenta, Accion)
VALUES(p_id, p_id_venta, p_accion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalleFallidas_SelectByVenta` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalleFallidas_SelectByVenta` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalleFallidas_SelectByVenta`(
IN p_id_venta INT(10)
)
BEGIN
Select IdVenta from VentasDetalleFallidas
where IdVenta = p_id_venta
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalle_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalle_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalle_Actualizar`(
in p_id_detalle int,
in p_articulo varchar(50),
in p_cantidad int,
in p_publico double,
IN p_costo DOUBLE,
IN p_mayor DOUBLE,
in p_forma_pago int,
in p_nro_cupon int,
in p_nro_factura int,
in p_id_empleado int,
in p_liquidado bit,
in p_devolucion bit
)
BEGIN
UPDATE VentasDetalle SET `IdArticuloDVEN` = p_articulo, `CantidadDVEN` = p_cantidad, `PrecioPublicoDVEN` = p_publico,
`PrecioCostoDVEN` = p_costo, `PrecioMayorDVEN` = p_mayor, `IdFormaPagoDVEN` = p_forma_pago, 
`NroCuponDVEN` = p_nro_cupon, `NroFacturaDVEN` = p_nro_factura, `IdEmpleadoDVEN` = p_id_empleado,
`LiquidadoDVEN` = p_liquidado, `DevolucionDVEN` = p_devolucion
WHERE `IdDVEN` = p_id_detalle
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalle_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalle_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalle_Borrar`(IN p_id_detalle INT)
BEGIN
DELETE
FROM VentasDetalle
WHERE `IdDVEN`= p_id_detalle
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalle_GetFallidas` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalle_GetFallidas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalle_GetFallidas`(
in p_id int
)
BEGIN
select * from VentasDetalle WHERE IdDVEN = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalle_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalle_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalle_Insertar`(
IN p_id_detalle INT,
IN p_id_venta INT,
IN p_id_local INT,
IN p_articulo VARCHAR(50),
IN p_cantidad INT,
IN p_publico DOUBLE,
IN p_costo DOUBLE,
IN p_mayor DOUBLE,
IN p_forma_pago INT,
IN p_nro_cupon INT,
IN p_nro_factura INT,
IN p_id_empleado INT,
IN p_liquidado BIT,
IN p_devolucion BIT
)
BEGIN
INSERT INTO VentasDetalle(`IdDVEN`, `IdVentaDVEN`, `IdLocalDVEN`, `IdArticuloDVEN`, `CantidadDVEN`, `PrecioPublicoDVEN`,
`PrecioCostoDVEN`, `PrecioMayorDVEN`, `IdFormaPagoDVEN`, `NroCuponDVEN`, `NroFacturaDVEN`, 
`IdEmpleadoDVEN`, `LiquidadoDVEN`, `DevolucionDVEN`)
VALUES(p_id_detalle, p_id_venta, p_id_local, p_articulo, p_cantidad, p_publico, p_costo, p_mayor, p_forma_pago, 
p_nro_cupon, p_nro_factura, p_id_empleado, p_liquidado, p_devolucion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasDetalle_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasDetalle_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasDetalle_Listar`()
BEGIN
select *
FROM VentasDetalle
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_Borrar`(
in p_id int,
in p_accion varchar(20)
)
BEGIN
DELETE FROM VentasFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_BorrarByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_BorrarByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_BorrarByAccion`(
in p_accion varchar(20)
)
BEGIN
DELETE FROM VentasFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_Existe` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_Existe` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_Existe`(
IN p_id int,
in p_accion varchar(20)
)
BEGIN
select * from VentasFallidas
where Id = p_id and Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_Get` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_Get` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_Get`(
in p_accion varchar(20)
)
BEGIN
select * from VentasFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_GetByAccion` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_GetByAccion` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_GetByAccion`(
in p_accion varchar(20)
)
BEGIN
select * from VentasFallidas
where Accion = p_accion
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_Insertar`(
IN p_id int(10),
in p_accion varchar(20)
)
BEGIN
INSERT INTO VentasFallidas(Id, Accion)
VALUES(p_id, p_accion)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasFallidas_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasFallidas_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasFallidas_Listar`(
in p_id int
)
BEGIN
select * from Ventas where IdVentaVEN = p_id;
select * from VentasDetalle WHERE IdVentaDVEN = p_id;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasHistoricas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasHistoricas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasHistoricas_Insertar`(
IN p_fecha date,
IN p_nombre varchar(50),
IN p_forma varchar(50),
IN p_total_publico decimal,
IN p_total_costo decimal,
IN p_prendas INT
)
BEGIN
INSERT INTO VentasH(`Fecha`, `NombreLocal`, `FormaPago`, `TotalPublico`, `TotalCosto`, `Prendas`)
VALUES(p_fecha, p_nombre, p_forma, p_total_publico, p_total_costo, p_prendas)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasH_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasH_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasH_Insertar`(IN p_fecha_hasta VARCHAR(50))
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE registros INT DEFAULT 0;
  DECLARE fecha_max DATE;
  DECLARE nombre_local VARCHAR(50);
  DECLARE cur1 CURSOR FOR SELECT `NombreLOC` FROM `ncsoftwa_re`.`Locales` WHERE NombreLOC<>'Entradas' AND NombreLOC<>'Salidas';
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
  
	DROP TEMPORARY TABLE IF EXISTS RegistrosTemp;
	CREATE TEMPORARY TABLE `RegistrosTemp` (`Cantidad` INT);  
  
  OPEN cur1;
  REPEAT 
    FETCH cur1 INTO nombre_local;
    IF NOT done THEN
		SET fecha_max = (SELECT MAX(Fecha) FROM VentasH WHERE NombreLocal = nombre_local);
		IF fecha_max IS NULL THEN
			SET registros = registros + (SELECT COUNT(Fecha) FROM VentasDiariasCons WHERE NombreLOC = nombre_local);	
			INSERT INTO VentasH (Fecha, NombreLocal, FormaPago, TotalPublico, TotalCosto, Prendas ) 
			SELECT Fecha, NombreLOC, DescripcionFOR, TotalPublico, TotalCosto, Prendas 
			FROM VentasDiariasCons
			WHERE Fecha<p_fecha_hasta and NombreLOC = nombre_local;			
		ELSE			
			SET registros = registros + (SELECT COUNT(Fecha) FROM VentasDiariasCons WHERE Fecha>fecha_max AND NombreLOC = nombre_local);	
			INSERT INTO VentasH (Fecha, NombreLocal, FormaPago, TotalPublico, TotalCosto, Prendas ) 
			SELECT Fecha, NombreLOC, DescripcionFOR, TotalPublico, TotalCosto, Prendas 
			FROM VentasDiariasCons
			WHERE Fecha>fecha_max AND Fecha<p_fecha_hasta and NombreLOC = nombre_local;	
		END IF;
    END IF;
  UNTIL done END REPEAT; 		
  CLOSE cur1;
  INSERT INTO RegistrosTemp (Cantidad) VALUES(registros);
  SELECT * FROM RegistrosTemp;
END */$$
DELIMITER ;

/* Procedure structure for procedure `VentasPesosCons_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `VentasPesosCons_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `VentasPesosCons_Listar`(
in p_locales varchar(200),
in p_forma int(2),
in p_fechaDesde varchar(50),
IN p_fechaHasta VARCHAR(50)
)
BEGIN
  DECLARE locales VARCHAR(50);
  DECLARE forma INT(2);
  DECLARE fechaDesde VARCHAR(50);
  DECLARE fechaHasta VARCHAR(50);
  SET locales = p_locales;
  SET forma = p_forma;
  SET fechaDesde = p_fechaDesde;
  SET fechaHasta = p_fechaHasta;
  
if forma =99 then
	SET @QUERY = CONCAT("SELECT 
	NombreLOC AS Local, SUM(Venta) AS Venta, SUM(Costo) AS Costo, SUM(Prendas) AS Prendas, 
	(SUM(Venta) - SUM(Costo)) AS 'Utilidad bruta', (((SUM(Venta)/SUM(Costo))-1)*100) AS 'Valor agregado'
	FROM VentasPesosCons 
	WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <'",fechaHasta,"')
	GROUP BY NombreLOC");
else
	SET @QUERY = CONCAT("SELECT 
	NombreLOC AS Local, SUM(Venta) AS Venta, SUM(Costo) AS Costo, SUM(Prendas) AS Prendas, 
	(SUM(Venta) - SUM(Costo)) AS 'Utilidad bruta', (((SUM(Venta)/SUM(Costo))-1)*100) AS 'Valor agregado'
	FROM VentasPesosCons 
	WHERE (",locales,") AND (FechaVEN >='",fechaDesde,"' AND FechaVEN <'",fechaHasta,"') AND IdFormaPagoDVEN =",p_forma,"
	GROUP BY NombreLOC");
END IF;
  
  PREPARE smpt FROM @QUERY;
  EXECUTE smpt;
  
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Actualizar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Actualizar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Actualizar`(
in p_id int,
IN p_id_pc INT,
IN p_fecha datetime,
in p_cliente int
)
BEGIN
update Ventas set IdPCVEN = p_id_pc, FechaVEN = p_fecha, IdClienteVEN = p_cliente
where `IdVentaVEN` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Arqueo` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Arqueo` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Arqueo`(
in p_fecha_desde varchar(50),
IN p_fecha_hasta VARCHAR(50),
in p_pc int(11)
)
BEGIN
SELECT * FROM arqueocons2
WHERE (`FechaVEN` >= p_fecha_desde AND `FechaVEN` < p_fecha_hasta) AND `IdPCVEN` = p_pc
;
SELECT `ImporteFONP` FROM FondoCaja
WHERE `FechaFONP` = (SELECT MAX(`FechaFONP`) FROM FondoCaja WHERE `FechaFONP` < p_fecha_desde)
AND `IdPcFONP` = p_pc
;
SELECT `ImporteFONP` FROM FondoCaja
WHERE `FechaFONP` = p_fecha_desde
AND `IdPcFONP` = p_pc
;
SELECT FechaTESM, IdMovTESM, DetalleTESM, ImporteTESM, IdPcTESM FROM `tesoreriamovimientos`
WHERE `FechaTESM` >= p_fecha_desde AND `FechaTESM` < p_fecha_hasta
AND `IdPcTESM` = p_pc
ORDER BY FechaTESM
;
SELECT sum(Subtotal) FROM arqueocons2
WHERE (`FechaVEN` >= p_fecha_desde AND `FechaVEN` < p_fecha_hasta) AND `IdPCVEN` = p_pc and `IdFormaPagoDVEN` = '1'
;
SELECT SUM(Subtotal) FROM arqueocons2
WHERE (`FechaVEN` >= p_fecha_desde AND `FechaVEN` < p_fecha_hasta) AND `IdPCVEN` = p_pc AND `IdFormaPagoDVEN` <> '1'
;
SELECT sum(ImporteTESM) FROM `TesoreriaMovimientos`
WHERE `FechaTESM` = p_fecha_desde
AND `IdPcTESM` = p_pc
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Borrar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Borrar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Borrar`(IN p_id INT)
BEGIN
DELETE
FROM Ventas
WHERE `IdVentaVEN` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Foraneos` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Foraneos` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Foraneos`()
BEGIN
select * FROM articulos;
SELECT * FROM clientes;
SELECT * FROM formaspago;
SELECT * FROM locales
	WHERE NombreLOC NOT LIKE 'Entradas' OR NombreLOC NOT LIKE 'Salidas'
	ORDER BY IdLocalLOC;
SELECT * FROM pc;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_GetByPK` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_GetByPK` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_GetByPK`(IN p_id INT)
BEGIN
select count(IdVentaVEN)
FROM Ventas
WHERE `IdVentaVEN` = p_id
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Historicas` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Historicas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Historicas`()
BEGIN
select *
FROM VentasH
order by Fecha
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Insertar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Insertar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Insertar`(
IN p_id INT,
IN p_id_pc INT,
IN p_fecha DATETIME,
IN p_cliente INT
)
BEGIN
INSERT INTO Ventas(`IdVentaVEN`, `IdPCVEN`, `FechaVEN`, `IdClienteVEN`)
VALUES(p_id, p_id_pc, p_fecha, p_cliente)
;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Listar` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Listar` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Listar`(
)
BEGIN
select * from Ventas;
select * from VentasDetalle;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Lotes_Tarjetas` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Lotes_Tarjetas` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Lotes_Tarjetas`(
IN p_pc int
)
BEGIN
DROP TABLE IF EXISTS lotes_tarjetas;
CREATE temporary TABLE lotes_tarjetas
AS SELECT
     `formaspago`.`DescripcionFOR`,
     SUM(`ventasdetalle`.`CantidadDVEN` * `ventasdetalle`.`PrecioPublicoDVEN`) AS subtotal_tarjeta
FROM
    `ventasdetalle`
    INNER JOIN `ventas` 
        ON (`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`)
    INNER JOIN `formaspago` 
        ON (`ventasdetalle`.`IdFormaPagoDVEN` = `formaspago`.`IdFormaPagoFOR`)
    WHERE (FechaVEN>=CURDATE() AND FechaVEN<DATE_ADD(CURDATE(),INTERVAL 1 DAY)) AND `IdPCVEN` = 1
    GROUP BY DescripcionFOR
    ORDER BY DescripcionFOR    
    ;
select * from lotes_tarjetas;
select sum(subtotal_tarjeta) total from lotes_tarjetas;
END */$$
DELIMITER ;

/* Procedure structure for procedure `Ventas_Schema` */

/*!50003 DROP PROCEDURE IF EXISTS  `Ventas_Schema` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ncsoftwa_re`@`%` PROCEDURE `Ventas_Schema`(
in p_id int
)
BEGIN
select * from Ventas where IdVentaVEN = p_id;
select * from VentasDetalle WHERE IdVentaDVEN = p_id;
END */$$
DELIMITER ;

/*Table structure for table `arqueocons` */

DROP TABLE IF EXISTS `arqueocons`;

/*!50001 DROP VIEW IF EXISTS `arqueocons` */;
/*!50001 DROP TABLE IF EXISTS `arqueocons` */;

/*!50001 CREATE TABLE  `arqueocons`(
 `IdVentaVEN` int(11) ,
 `IdPCVEN` int(11) ,
 `FechaVEN` datetime ,
 `IdClienteVEN` int(11) ,
 `IdDVEN` int(11) ,
 `IdVentaDVEN` int(11) ,
 `IdArticuloDVEN` varchar(50) ,
 `DescripcionDVEN` varchar(50) ,
 `CantidadDVEN` int(11) ,
 `PrecioPublicoDVEN` double ,
 `PrecioCostoDVEN` double ,
 `PrecioMayorDVEN` double ,
 `IdFormaPagoDVEN` int(11) ,
 `NroCuponDVEN` int(11) ,
 `NroFacturaDVEN` int(11) ,
 `IdEmpleadoDVEN` int(11) ,
 `LiquidadoDVEN` bit(1) ,
 `EsperaDVEN` bit(1) ,
 `DevolucionDVEN` smallint(1) ,
 `DescripcionART` varchar(55) ,
 `DescripcionFOR` varchar(50) 
)*/;

/*Table structure for table `arqueocons2` */

DROP TABLE IF EXISTS `arqueocons2`;

/*!50001 DROP VIEW IF EXISTS `arqueocons2` */;
/*!50001 DROP TABLE IF EXISTS `arqueocons2` */;

/*!50001 CREATE TABLE  `arqueocons2`(
 `IdVentaVEN` int(11) ,
 `FechaVEN` datetime ,
 `IdPCVEN` int(11) ,
 `IdClienteVEN` int(11) ,
 `IdDVEN` int(11) ,
 `IdVentaDVEN` int(11) ,
 `IdLocalDVEN` int(3) ,
 `IdArticuloDVEN` varchar(50) ,
 `Descripcion` varchar(55) ,
 `CantidadDVEN` int(11) ,
 `PrecioPublicoDVEN` double ,
 `PrecioCostoDVEN` double ,
 `PrecioMayorDVEN` double ,
 `IdFormaPagoDVEN` int(11) ,
 `NroCuponDVEN` int(11) ,
 `NroFacturaDVEN` int(11) ,
 `IdEmpleadoDVEN` int(11) ,
 `LiquidadoDVEN` bit(1) ,
 `EsperaDVEN` bit(1) ,
 `DevolucionDVEN` smallint(1) ,
 `Forma pago` varchar(50) ,
 `Subtotal` double 
)*/;

/*Table structure for table `articuloscons` */

DROP TABLE IF EXISTS `articuloscons`;

/*!50001 DROP VIEW IF EXISTS `articuloscons` */;
/*!50001 DROP TABLE IF EXISTS `articuloscons` */;

/*!50001 CREATE TABLE  `articuloscons`(
 `IdArticuloART` varchar(50) ,
 `IdAliculotaIvaART` tinyint(2) ,
 `DescripcionART` varchar(55) ,
 `PrecioCostoART` decimal(19,0) ,
 `PrecioPublicoART` decimal(19,0) ,
 `PrecioMayorART` decimal(19,0) ,
 `PorcentajeALI` decimal(10,2) 
)*/;

/*Table structure for table `clientescons` */

DROP TABLE IF EXISTS `clientescons`;

/*!50001 DROP VIEW IF EXISTS `clientescons` */;
/*!50001 DROP TABLE IF EXISTS `clientescons` */;

/*!50001 CREATE TABLE  `clientescons`(
 `IdClienteCLI` int(11) ,
 `RazonSocialCLI` varchar(50) ,
 `CUIT` varchar(50) ,
 `CondicionIvaCLI` varchar(50) ,
 `DireccionCLI` varchar(50) ,
 `LocalidadCLI` varchar(50) ,
 `ProvinciaCLI` varchar(50) ,
 `TransporteCLI` varchar(50) ,
 `ContactoCLI` varchar(50) ,
 `TelefonoCLI` varchar(50) ,
 `MovilCLI` varchar(50) ,
 `CorreoCLI` varchar(60) ,
 `DescripcionCIVA` varchar(50) 
)*/;

/*Table structure for table `fondocajacons` */

DROP TABLE IF EXISTS `fondocajacons`;

/*!50001 DROP VIEW IF EXISTS `fondocajacons` */;
/*!50001 DROP TABLE IF EXISTS `fondocajacons` */;

/*!50001 CREATE TABLE  `fondocajacons`(
 `FechaFONP` datetime ,
 `IdPcFONP` int(11) ,
 `IdLocalLOC` int(11) ,
 `NombreLOC` varchar(50) ,
 `Detalle` varchar(50) ,
 `ImporteFONP` double 
)*/;

/*Table structure for table `localescons` */

DROP TABLE IF EXISTS `localescons`;

/*!50001 DROP VIEW IF EXISTS `localescons` */;
/*!50001 DROP TABLE IF EXISTS `localescons` */;

/*!50001 CREATE TABLE  `localescons`(
 `IdLocalLOC` int(11) 
)*/;

/*Table structure for table `razonsocialcons` */

DROP TABLE IF EXISTS `razonsocialcons`;

/*!50001 DROP VIEW IF EXISTS `razonsocialcons` */;
/*!50001 DROP TABLE IF EXISTS `razonsocialcons` */;

/*!50001 CREATE TABLE  `razonsocialcons`(
 `IdRazonSocialRAZ` tinyint(2) ,
 `RazonSocialRAZ` varchar(50) ,
 `NombreFantasiaRAZ` varchar(50) ,
 `DomicilioRAZ` varchar(50) ,
 `LocalidadRAZ` varchar(50) ,
 `ProvinciaRAZ` varchar(50) ,
 `IdCondicionIvaRAZ` tinyint(2) ,
 `CuitRAZ` varchar(15) ,
 `IngresosBrutosRAZ` varchar(15) ,
 `InicioActividadRAZ` datetime ,
 `PuntoVentaRAZ` varchar(4) ,
 `DescripcionCIVA` varchar(50) ,
 `CorreoRAZ` varchar(50) 
)*/;

/*Table structure for table `ventasarqueocons` */

DROP TABLE IF EXISTS `ventasarqueocons`;

/*!50001 DROP VIEW IF EXISTS `ventasarqueocons` */;
/*!50001 DROP TABLE IF EXISTS `ventasarqueocons` */;

/*!50001 CREATE TABLE  `ventasarqueocons`(
 `IdPCVEN` int(11) ,
 `FechaVEN` datetime ,
 `IdDVEN` int(11) ,
 `IdVentaDVEN` int(11) ,
 `IdArticuloDVEN` varchar(50) ,
 `DescripcionDVEN` varchar(50) ,
 `CantidadDVEN` int(11) ,
 `PrecioPublicoDVEN` double ,
 `PrecioCostoDVEN` double ,
 `PrecioMayorDVEN` double ,
 `IdFormaPagoDVEN` int(11) ,
 `NroCuponDVEN` int(11) ,
 `NroFacturaDVEN` int(11) ,
 `IdEmpleadoDVEN` int(11) ,
 `LiquidadoDVEN` bit(1) ,
 `EsperaDVEN` bit(1) ,
 `DevolucionDVEN` smallint(1) ,
 `IdLocalDVEN` int(3) 
)*/;

/*Table structure for table `ventasdetallecons` */

DROP TABLE IF EXISTS `ventasdetallecons`;

/*!50001 DROP VIEW IF EXISTS `ventasdetallecons` */;
/*!50001 DROP TABLE IF EXISTS `ventasdetallecons` */;

/*!50001 CREATE TABLE  `ventasdetallecons`(
 `IdLocalLOC` int(11) ,
 `NombreLOC` varchar(50) ,
 `FechaVEN` datetime ,
 `IdDVEN` int(11) ,
 `IdArticuloDVEN` varchar(50) ,
 `DescripcionART` varchar(55) ,
 `CantidadDVEN` int(11) ,
 `PrecioPublicoDVEN` double ,
 `IdFormaPagoFOR` int(11) ,
 `DescripcionFOR` varchar(50) 
)*/;

/*Table structure for table `ventasdiariascons` */

DROP TABLE IF EXISTS `ventasdiariascons`;

/*!50001 DROP VIEW IF EXISTS `ventasdiariascons` */;
/*!50001 DROP TABLE IF EXISTS `ventasdiariascons` */;

/*!50001 CREATE TABLE  `ventasdiariascons`(
 `Fecha` varchar(10) ,
 `NombreLOC` varchar(50) ,
 `DescripcionFOR` varchar(50) ,
 `TotalPublico` double ,
 `TotalCosto` double ,
 `Prendas` decimal(32,0) 
)*/;

/*Table structure for table `ventaspesoscons` */

DROP TABLE IF EXISTS `ventaspesoscons`;

/*!50001 DROP VIEW IF EXISTS `ventaspesoscons` */;
/*!50001 DROP TABLE IF EXISTS `ventaspesoscons` */;

/*!50001 CREATE TABLE  `ventaspesoscons`(
 `IdLocalLOC` int(11) ,
 `NombreLOC` varchar(50) ,
 `FechaVEN` datetime ,
 `IdFormaPagoDVEN` int(11) ,
 `Prendas` int(11) ,
 `Costo` double ,
 `Venta` double 
)*/;

/*Table structure for table `ventaspesoscons2` */

DROP TABLE IF EXISTS `ventaspesoscons2`;

/*!50001 DROP VIEW IF EXISTS `ventaspesoscons2` */;
/*!50001 DROP TABLE IF EXISTS `ventaspesoscons2` */;

/*!50001 CREATE TABLE  `ventaspesoscons2`(
 `IdLocalLOC` int(11) ,
 `NombreLOC` varchar(50) ,
 `FechaVEN` datetime ,
 `CantidadDVEN` int(11) ,
 `PrecioPublicoDVEN` double ,
 `PrecioCostoDVEN` double ,
 `IdFormaPagoDVEN` int(11) 
)*/;

/*View structure for view arqueocons */

/*!50001 DROP TABLE IF EXISTS `arqueocons` */;
/*!50001 DROP VIEW IF EXISTS `arqueocons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `arqueocons` AS select `ventas`.`IdVentaVEN` AS `IdVentaVEN`,`ventas`.`IdPCVEN` AS `IdPCVEN`,`ventas`.`FechaVEN` AS `FechaVEN`,`ventas`.`IdClienteVEN` AS `IdClienteVEN`,`ventasdetalle`.`IdDVEN` AS `IdDVEN`,`ventasdetalle`.`IdVentaDVEN` AS `IdVentaDVEN`,`ventasdetalle`.`IdArticuloDVEN` AS `IdArticuloDVEN`,`ventasdetalle`.`DescripcionDVEN` AS `DescripcionDVEN`,`ventasdetalle`.`CantidadDVEN` AS `CantidadDVEN`,`ventasdetalle`.`PrecioPublicoDVEN` AS `PrecioPublicoDVEN`,`ventasdetalle`.`PrecioCostoDVEN` AS `PrecioCostoDVEN`,`ventasdetalle`.`PrecioMayorDVEN` AS `PrecioMayorDVEN`,`ventasdetalle`.`IdFormaPagoDVEN` AS `IdFormaPagoDVEN`,`ventasdetalle`.`NroCuponDVEN` AS `NroCuponDVEN`,`ventasdetalle`.`NroFacturaDVEN` AS `NroFacturaDVEN`,`ventasdetalle`.`IdEmpleadoDVEN` AS `IdEmpleadoDVEN`,`ventasdetalle`.`LiquidadoDVEN` AS `LiquidadoDVEN`,`ventasdetalle`.`EsperaDVEN` AS `EsperaDVEN`,`ventasdetalle`.`DevolucionDVEN` AS `DevolucionDVEN`,`articulos`.`DescripcionART` AS `DescripcionART`,`formaspago`.`DescripcionFOR` AS `DescripcionFOR` from (((`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) join `articulos` on((`ventasdetalle`.`IdArticuloDVEN` = `articulos`.`IdArticuloART`))) join `formaspago` on((`ventasdetalle`.`IdFormaPagoDVEN` = `formaspago`.`IdFormaPagoFOR`))) */;

/*View structure for view arqueocons2 */

/*!50001 DROP TABLE IF EXISTS `arqueocons2` */;
/*!50001 DROP VIEW IF EXISTS `arqueocons2` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `arqueocons2` AS select `ventas`.`IdVentaVEN` AS `IdVentaVEN`,`ventas`.`FechaVEN` AS `FechaVEN`,`ventas`.`IdPCVEN` AS `IdPCVEN`,`ventas`.`IdClienteVEN` AS `IdClienteVEN`,`ventasdetalle`.`IdDVEN` AS `IdDVEN`,`ventasdetalle`.`IdVentaDVEN` AS `IdVentaDVEN`,`ventasdetalle`.`IdLocalDVEN` AS `IdLocalDVEN`,`ventasdetalle`.`IdArticuloDVEN` AS `IdArticuloDVEN`,`articulos`.`DescripcionART` AS `Descripcion`,`ventasdetalle`.`CantidadDVEN` AS `CantidadDVEN`,`ventasdetalle`.`PrecioPublicoDVEN` AS `PrecioPublicoDVEN`,`ventasdetalle`.`PrecioCostoDVEN` AS `PrecioCostoDVEN`,`ventasdetalle`.`PrecioMayorDVEN` AS `PrecioMayorDVEN`,`ventasdetalle`.`IdFormaPagoDVEN` AS `IdFormaPagoDVEN`,`ventasdetalle`.`NroCuponDVEN` AS `NroCuponDVEN`,`ventasdetalle`.`NroFacturaDVEN` AS `NroFacturaDVEN`,`ventasdetalle`.`IdEmpleadoDVEN` AS `IdEmpleadoDVEN`,`ventasdetalle`.`LiquidadoDVEN` AS `LiquidadoDVEN`,`ventasdetalle`.`EsperaDVEN` AS `EsperaDVEN`,`ventasdetalle`.`DevolucionDVEN` AS `DevolucionDVEN`,`formaspago`.`DescripcionFOR` AS `Forma pago`,(`ventasdetalle`.`CantidadDVEN` * `ventasdetalle`.`PrecioPublicoDVEN`) AS `Subtotal` from (((`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) join `articulos` on((`ventasdetalle`.`IdArticuloDVEN` = `articulos`.`IdArticuloART`))) join `formaspago` on((`ventasdetalle`.`IdFormaPagoDVEN` = `formaspago`.`IdFormaPagoFOR`))) order by `ventas`.`FechaVEN` desc */;

/*View structure for view articuloscons */

/*!50001 DROP TABLE IF EXISTS `articuloscons` */;
/*!50001 DROP VIEW IF EXISTS `articuloscons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `articuloscons` AS select `articulos`.`IdArticuloART` AS `IdArticuloART`,`articulos`.`IdAliculotaIvaART` AS `IdAliculotaIvaART`,`articulos`.`DescripcionART` AS `DescripcionART`,`articulos`.`PrecioCostoART` AS `PrecioCostoART`,`articulos`.`PrecioPublicoART` AS `PrecioPublicoART`,`articulos`.`PrecioMayorART` AS `PrecioMayorART`,`alicuotasiva`.`PorcentajeALI` AS `PorcentajeALI` from (`articulos` join `alicuotasiva` on((`articulos`.`IdAliculotaIvaART` = `alicuotasiva`.`IdAlicuotaALI`))) */;

/*View structure for view clientescons */

/*!50001 DROP TABLE IF EXISTS `clientescons` */;
/*!50001 DROP VIEW IF EXISTS `clientescons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `clientescons` AS select `clientes`.`IdClienteCLI` AS `IdClienteCLI`,`clientes`.`RazonSocialCLI` AS `RazonSocialCLI`,`clientes`.`CUIT` AS `CUIT`,`clientes`.`CondicionIvaCLI` AS `CondicionIvaCLI`,`clientes`.`DireccionCLI` AS `DireccionCLI`,`clientes`.`LocalidadCLI` AS `LocalidadCLI`,`clientes`.`ProvinciaCLI` AS `ProvinciaCLI`,`clientes`.`TransporteCLI` AS `TransporteCLI`,`clientes`.`ContactoCLI` AS `ContactoCLI`,`clientes`.`TelefonoCLI` AS `TelefonoCLI`,`clientes`.`MovilCLI` AS `MovilCLI`,`clientes`.`CorreoCLI` AS `CorreoCLI`,`condicioniva`.`DescripcionCIVA` AS `DescripcionCIVA` from (`clientes` join `condicioniva` on((`clientes`.`CondicionIvaCLI` = `condicioniva`.`IdCondicionIvaCIVA`))) */;

/*View structure for view fondocajacons */

/*!50001 DROP TABLE IF EXISTS `fondocajacons` */;
/*!50001 DROP VIEW IF EXISTS `fondocajacons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `fondocajacons` AS select `fondocaja`.`FechaFONP` AS `FechaFONP`,`fondocaja`.`IdPcFONP` AS `IdPcFONP`,`locales`.`IdLocalLOC` AS `IdLocalLOC`,`locales`.`NombreLOC` AS `NombreLOC`,`pc`.`Detalle` AS `Detalle`,`fondocaja`.`ImporteFONP` AS `ImporteFONP` from ((`pc` join `locales` on((`pc`.`IdLocalPC` = `locales`.`IdLocalLOC`))) join `fondocaja` on((`fondocaja`.`IdPcFONP` = `pc`.`IdPC`))) order by `fondocaja`.`FechaFONP` */;

/*View structure for view localescons */

/*!50001 DROP TABLE IF EXISTS `localescons` */;
/*!50001 DROP VIEW IF EXISTS `localescons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `localescons` AS select `locales`.`IdLocalLOC` AS `IdLocalLOC` from `locales` where ((`locales`.`IdLocalLOC` <> 1) and (`locales`.`IdLocalLOC` <> 2)) */;

/*View structure for view razonsocialcons */

/*!50001 DROP TABLE IF EXISTS `razonsocialcons` */;
/*!50001 DROP VIEW IF EXISTS `razonsocialcons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `razonsocialcons` AS select `razonsocial`.`IdRazonSocialRAZ` AS `IdRazonSocialRAZ`,`razonsocial`.`RazonSocialRAZ` AS `RazonSocialRAZ`,`razonsocial`.`NombreFantasiaRAZ` AS `NombreFantasiaRAZ`,`razonsocial`.`DomicilioRAZ` AS `DomicilioRAZ`,`razonsocial`.`LocalidadRAZ` AS `LocalidadRAZ`,`razonsocial`.`ProvinciaRAZ` AS `ProvinciaRAZ`,`razonsocial`.`IdCondicionIvaRAZ` AS `IdCondicionIvaRAZ`,`razonsocial`.`CuitRAZ` AS `CuitRAZ`,`razonsocial`.`IngresosBrutosRAZ` AS `IngresosBrutosRAZ`,`razonsocial`.`InicioActividadRAZ` AS `InicioActividadRAZ`,`razonsocial`.`PuntoVentaRAZ` AS `PuntoVentaRAZ`,`condicioniva`.`DescripcionCIVA` AS `DescripcionCIVA`,`razonsocial`.`CorreoRAZ` AS `CorreoRAZ` from (`razonsocial` join `condicioniva` on((`razonsocial`.`IdCondicionIvaRAZ` = `condicioniva`.`IdCondicionIvaCIVA`))) */;

/*View structure for view ventasarqueocons */

/*!50001 DROP TABLE IF EXISTS `ventasarqueocons` */;
/*!50001 DROP VIEW IF EXISTS `ventasarqueocons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `ventasarqueocons` AS select `ventas`.`IdPCVEN` AS `IdPCVEN`,`ventas`.`FechaVEN` AS `FechaVEN`,`ventasdetalle`.`IdDVEN` AS `IdDVEN`,`ventasdetalle`.`IdVentaDVEN` AS `IdVentaDVEN`,`ventasdetalle`.`IdArticuloDVEN` AS `IdArticuloDVEN`,`ventasdetalle`.`DescripcionDVEN` AS `DescripcionDVEN`,`ventasdetalle`.`CantidadDVEN` AS `CantidadDVEN`,`ventasdetalle`.`PrecioPublicoDVEN` AS `PrecioPublicoDVEN`,`ventasdetalle`.`PrecioCostoDVEN` AS `PrecioCostoDVEN`,`ventasdetalle`.`PrecioMayorDVEN` AS `PrecioMayorDVEN`,`ventasdetalle`.`IdFormaPagoDVEN` AS `IdFormaPagoDVEN`,`ventasdetalle`.`NroCuponDVEN` AS `NroCuponDVEN`,`ventasdetalle`.`NroFacturaDVEN` AS `NroFacturaDVEN`,`ventasdetalle`.`IdEmpleadoDVEN` AS `IdEmpleadoDVEN`,`ventasdetalle`.`LiquidadoDVEN` AS `LiquidadoDVEN`,`ventasdetalle`.`EsperaDVEN` AS `EsperaDVEN`,`ventasdetalle`.`DevolucionDVEN` AS `DevolucionDVEN`,`ventasdetalle`.`IdLocalDVEN` AS `IdLocalDVEN` from (`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) */;

/*View structure for view ventasdetallecons */

/*!50001 DROP TABLE IF EXISTS `ventasdetallecons` */;
/*!50001 DROP VIEW IF EXISTS `ventasdetallecons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `ventasdetallecons` AS select `locales`.`IdLocalLOC` AS `IdLocalLOC`,`locales`.`NombreLOC` AS `NombreLOC`,`ventas`.`FechaVEN` AS `FechaVEN`,`ventasdetalle`.`IdDVEN` AS `IdDVEN`,`ventasdetalle`.`IdArticuloDVEN` AS `IdArticuloDVEN`,`articulos`.`DescripcionART` AS `DescripcionART`,`ventasdetalle`.`CantidadDVEN` AS `CantidadDVEN`,`ventasdetalle`.`PrecioPublicoDVEN` AS `PrecioPublicoDVEN`,`formaspago`.`IdFormaPagoFOR` AS `IdFormaPagoFOR`,`formaspago`.`DescripcionFOR` AS `DescripcionFOR` from (((((`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) join `pc` on((`ventas`.`IdPCVEN` = `pc`.`IdPC`))) join `locales` on((`pc`.`IdLocalPC` = `locales`.`IdLocalLOC`))) join `articulos` on((`ventasdetalle`.`IdArticuloDVEN` = `articulos`.`IdArticuloART`))) join `formaspago` on((`ventasdetalle`.`IdFormaPagoDVEN` = `formaspago`.`IdFormaPagoFOR`))) */;

/*View structure for view ventasdiariascons */

/*!50001 DROP TABLE IF EXISTS `ventasdiariascons` */;
/*!50001 DROP VIEW IF EXISTS `ventasdiariascons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `ventasdiariascons` AS select date_format(`ventas`.`FechaVEN`,'%Y-%m-%d') AS `Fecha`,`locales`.`NombreLOC` AS `NombreLOC`,`formaspago`.`DescripcionFOR` AS `DescripcionFOR`,sum((`ventasdetalle`.`CantidadDVEN` * `ventasdetalle`.`PrecioPublicoDVEN`)) AS `TotalPublico`,sum((`ventasdetalle`.`CantidadDVEN` * `ventasdetalle`.`PrecioCostoDVEN`)) AS `TotalCosto`,sum(`ventasdetalle`.`CantidadDVEN`) AS `Prendas` from ((((`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) join `pc` on((`ventas`.`IdPCVEN` = `pc`.`IdPC`))) join `locales` on((`pc`.`IdLocalPC` = `locales`.`IdLocalLOC`))) join `formaspago` on((`ventasdetalle`.`IdFormaPagoDVEN` = `formaspago`.`IdFormaPagoFOR`))) where ((`locales`.`NombreLOC` <> 'Entradas') and (`locales`.`NombreLOC` <> 'Salidas')) group by date_format(`ventas`.`FechaVEN`,'%Y-%m-%d'),`locales`.`NombreLOC`,`formaspago`.`DescripcionFOR` order by date_format(`ventas`.`FechaVEN`,'%Y-%m-%d') */;

/*View structure for view ventaspesoscons */

/*!50001 DROP TABLE IF EXISTS `ventaspesoscons` */;
/*!50001 DROP VIEW IF EXISTS `ventaspesoscons` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `ventaspesoscons` AS select `locales`.`IdLocalLOC` AS `IdLocalLOC`,`locales`.`NombreLOC` AS `NombreLOC`,`ventas`.`FechaVEN` AS `FechaVEN`,`ventasdetalle`.`IdFormaPagoDVEN` AS `IdFormaPagoDVEN`,`ventasdetalle`.`CantidadDVEN` AS `Prendas`,(`ventasdetalle`.`PrecioCostoDVEN` * `ventasdetalle`.`CantidadDVEN`) AS `Costo`,(`ventasdetalle`.`PrecioPublicoDVEN` * `ventasdetalle`.`CantidadDVEN`) AS `Venta` from (((`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) join `pc` on((`ventas`.`IdPCVEN` = `pc`.`IdPC`))) join `locales` on((`pc`.`IdLocalPC` = `locales`.`IdLocalLOC`))) */;

/*View structure for view ventaspesoscons2 */

/*!50001 DROP TABLE IF EXISTS `ventaspesoscons2` */;
/*!50001 DROP VIEW IF EXISTS `ventaspesoscons2` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ncsoftwa_re`@`%` SQL SECURITY DEFINER VIEW `ventaspesoscons2` AS select `locales`.`IdLocalLOC` AS `IdLocalLOC`,`locales`.`NombreLOC` AS `NombreLOC`,`ventas`.`FechaVEN` AS `FechaVEN`,`ventasdetalle`.`CantidadDVEN` AS `CantidadDVEN`,`ventasdetalle`.`PrecioPublicoDVEN` AS `PrecioPublicoDVEN`,`ventasdetalle`.`PrecioCostoDVEN` AS `PrecioCostoDVEN`,`ventasdetalle`.`IdFormaPagoDVEN` AS `IdFormaPagoDVEN` from (((`ventasdetalle` join `ventas` on((`ventasdetalle`.`IdVentaDVEN` = `ventas`.`IdVentaVEN`))) join `pc` on((`ventas`.`IdPCVEN` = `pc`.`IdPC`))) join `locales` on((`pc`.`IdLocalPC` = `locales`.`IdLocalLOC`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
