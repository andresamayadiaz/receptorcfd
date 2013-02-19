#!/bin/bash
# andres.amaya.diaz@gmail.com

cd /tmp/

# CSD.txt - Certificados Sellos Digitales
wget -N /tmp/CSD.txt ftp://ftp2.sat.gob.mx/agti_servicio_ftp/verifica_comprobante_ftp/CSD.txt -O /tmp/CSD.txt
mysql -uroot -pceis12345 receptorcfd_dev --local-infile -e "TRUNCATE TABLE cfdcsds; LOAD DATA LOCAL INFILE '/tmp/CSD.txt' INTO TABLE cfdcsds FIELDS TERMINATED BY '|' LINES TERMINATED BY '\\n' IGNORE 1 LINES (no_serie, fec_inicial_cert, fec_final_cert, RFC, edo_certificado)"

# FoliosCFD.txt - Folios y Series Autorizados
# URL: ftp://ftp2.sat.gob.mx/agti_servicio_ftp/verifica_comprobante_ftp/FoliosCFD.txt
wget -N /tmp/FoliosCFD.txt ftp://ftp2.sat.gob.mx/agti_servicio_ftp/verifica_comprobante_ftp/FoliosCFD.txt -O /tmp/FoliosCFD.txt
mysql -uroot -pceis12345 receptorcfd_dev --local-infile -e "TRUNCATE TABLE cfdfolios; LOAD DATA LOCAL INFILE '/tmp/FoliosCFD.txt' INTO TABLE cfdfolios FIELDS TERMINATED BY '|' LINES TERMINATED BY '\\n' IGNORE 1 LINES (RFC, NoAprobacion, AnoAprobacion, Serie, FolioInicial,FolioFinal)"
