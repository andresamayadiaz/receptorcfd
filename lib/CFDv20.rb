class Cfd20 < ApplicationController
	
	require 'nokogiri'
	attr_accessible :version, :serie, :folio, :fecha, :sello, :noAprobacion, :anoAprobacion, :tipoDeComprobante, :formaDePago, :condicionesDePago, :noCertificado, :certificado, :subTotal, :descuento, :total, :metodoDePago, :LugarExpedicion, :NumCtaPago, :TipoCambio, :Moneda, :Emisor, :Receptor
		
	def from_xml(xml_file_path)
		
		doc = Nokogiri::XML( File.read(xml_file_path) )
		
		@serie = doc.root.attribute("serie").to_s
		@version = doc.root.attribute("version").to_s
		@fecha = doc.root.attribute("fecha").to_s
		@sello = doc.root.attribute("sello").to_s
		@noAprobacion = doc.root.attribute("noAprobacion").to_s
		@anoAprobacion = doc.root.attribute("anoAprobacion").to_s
		@tipoDeComprobante = doc.root.attribute("tipoDeComprobante").to_s
		@formaDePago = doc.root.attribute("formaDePago").to_s
		@condicionesDePago = doc.root.attribute("condicionesDePago").to_s
		@noCertificado = doc.root.attribute("noCertificado").to_s
		@certificado = doc.root.attribute("certificado").to_s
		@subTotal = doc.root.attribute("subTotal").to_s
		@descuento = doc.root.attribute("desceunto").to_s
		@total = doc.root.attribute("total").to_s
		@metodoDePago = doc.root.attribute("metodoDePago").to_s
		@LugarExpedicion = doc.root.attribute("LugarExpedicion").to_s
		@NumCtaPago = doc.root.attribute("NumCtaPago").to_s
		@TipoCambio = doc.root.attribute("TipoCambio").to_s
		@Moneda = doc.root.attribute("Moneda").to_s
		@Emisor = Emisor.from_xml_doc (doc)
		@Receptor = 
		
	end

end

class Emisor < ApplicationController

	attr_accessible :rfc, :nombre, :DomicilioFiscal	
	
	def from_xml_doc (xml_doc)
	
		
	
	end

end

class DomicilioFiscal < ApplicationController

	attr_accessible :calle, :noExterior, :noInterior, :colonia, :localidad, :municipio, :estado, :pais, :codigoPostal

end

class ExpedidoEn < ApplicationController

	attr_accessible :calle, :noExterior, :noInterior, :colonia, :localidad, :municipio, :estado, :pais, :codigoPostal

end

class RegimenFiscal < ApplicationController

	attr_accessible :Regimen

end

class Receptor < ApplicationController

	attr_accessible :rfc, :nombre, :Domicilio	
	
	def from_xml_doc(xml_doc)
	
		
	
	end

end

class Domicilio < ApplicationController

	attr_accessible :calle, :noExterior, :noInterior, :colonia, :localidad, :municipio, :estado, :pais, :codigoPostal

end

class Concepto < ApplicationController

	attr_accessible :cantidad, :unidad, :descripcion, :valorUnitario, :importe

end

class Impuestos < ApplicationController

	attr_accessible :totalImpuestosRetenidos, :totalImpuestosTrasladados, :Traslados, :Retenciones

end

class Traslado < ApplicationController

	attr_accessible :impuesto, :tasa, :importe

end

class Retencion < ApplicationController

	attr_accessible :impuesto, :importe	

end

class Addenda < ApplicationController

	attr_accessible :xml

end