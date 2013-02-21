class Cfd20 < ApplicationController
	
	require 'nokogiri'
	attr_accessible :version, :serie, :folio, :fecha, :sello, :noAprobacion, :anoAprobacion, :tipoDeComprobante, :formaDePago, :condicionesDePago, :noCertificado, :certificado, :subTotal, :descuento, :total, :metodoDePago, :LugarExpedicion, :Emisor, :Receptor
		
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
		@Emisor = Emisor.from_xml_doc (doc)
		@Receptor = Receptor.from_xml_doc (doc)
		
	end

end

class Emisor < ApplicationController

	attr_accessible :rfc, :nombre, :DomicilioFiscal	
	
	def from_xml_doc (doc)
	
		@rfc = doc.root.xpath("//Emisor").attribute("rfc").to_s
		@nombre = doc.root.xpath("//Emisor").attribute("nombre").to_s
		@DomicilioFiscal = DomicilioFiscal.from_xml_doc(doc)
	
	end

end

class DomicilioFiscal < ApplicationController

	attr_accessible :calle, :noExterior, :noInterior, :colonia, :localidad, :municipio, :estado, :pais, :codigoPostal

	def from_xml_doc (doc)
	
		@calle = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("calle").to_s
		@noExterior = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("noExterior").to_s
		@noInterior = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("noInterior").to_s
		@colonia = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("colonia").to_s
		@localidad = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("localidad").to_s
		@municipio = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("municipio").to_s
		@estado = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("estado").to_s
		@pais = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("pais").to_s
		@codigoPostal = doc.root.xpath("//Emisor//DomicilioFiscal").attribute("codigoPostal").to_s
	
	end

end

class ExpedidoEn < ApplicationController

	attr_accessible :calle, :noExterior, :noInterior, :colonia, :localidad, :municipio, :estado, :pais, :codigoPostal

	def from_xml_doc (doc)
	
		@calle = doc.root.xpath("//Emisor//ExpedidoEn").attribute("calle").to_s
		@noExterior = doc.root.xpath("//Emisor//ExpedidoEn").attribute("noExterior").to_s
		@noInterior = doc.root.xpath("//Emisor//ExpedidoEn").attribute("noInterior").to_s
		@colonia = doc.root.xpath("//Emisor//ExpedidoEn").attribute("colonia").to_s
		@localidad = doc.root.xpath("//Emisor//ExpedidoEn").attribute("localidad").to_s
		@municipio = doc.root.xpath("//Emisor//ExpedidoEn").attribute("municipio").to_s
		@estado = doc.root.xpath("//Emisor//ExpedidoEn").attribute("estado").to_s
		@pais = doc.root.xpath("//Emisor//ExpedidoEn").attribute("pais").to_s
		@codigoPostal = doc.root.xpath("//Emisor//ExpedidoEn").attribute("codigoPostal").to_s
	
	end

end

class Receptor < ApplicationController

	attr_accessible :rfc, :nombre, :Domicilio	
	
	def from_xml_doc (doc)
	
		@rfc = doc.root.xpath("//Receptor").attribute("rfc").to_s
		@nombre = doc.root.xpath("//Receptor").attribute("nombre").to_s
		@Domicilio = Domicilio.from_xml_doc(doc)
	
	end

end

class Domicilio < ApplicationController

	attr_accessible :calle, :noExterior, :noInterior, :colonia, :localidad, :municipio, :estado, :pais, :codigoPostal

	def from_xml_doc (doc)
	
		@calle = doc.root.xpath("//Receptor//Domicilio").attribute("calle").to_s
		@noExterior = doc.root.xpath("//Receptor//Domicilio").attribute("noExterior").to_s
		@noInterior = doc.root.xpath("//Receptor//Domicilio").attribute("noInterior").to_s
		@colonia = doc.root.xpath("//Receptor//Domicilio").attribute("colonia").to_s
		@localidad = doc.root.xpath("//Receptor//Domicilio").attribute("localidad").to_s
		@municipio = doc.root.xpath("//Receptor//Domicilio").attribute("municipio").to_s
		@estado = doc.root.xpath("//Receptor//Domicilio").attribute("estado").to_s
		@pais = doc.root.xpath("//Receptor//Domicilio").attribute("pais").to_s
		@codigoPostal = doc.root.xpath("//Receptor//Domicilio").attribute("codigoPostal").to_s
	
	end

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