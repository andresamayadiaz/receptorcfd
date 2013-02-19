class Comprobante < ActiveRecord::Base
  
  require 'nokogiri'
  require 'open-uri'
  
  attr_accessible :fecha, :folio, :rfcemisor, :rfcreceptor, :serie, :subtotal, :total, :uuid
  
  # URL Archivos SAT
  # ftp://ftp2.sat.gob.mx/agti_servicio_ftp/verifica_comprobante_ftp/ CSD.txt FoliosCSD.txt
  
  # Valida la estructura del Comprobante
  def validate_schema(xml_file_path)
    
    # open("http://www.sat.gob.mx/cfd/3/cfdv32.xsd")
    xml_file_path = "/home/administrador/receptorcfd/public/comprobante32.xml"
    doc = Nokogiri::XML( File.read(xml_file_path) )
    
    #puts "KEYS: " + doc.root.keys.to_s
    #puts "Schema: " + doc.root["xsi:schemaLocation"]
    #puts doc.xpath("//*[@xsi:schemaLocation]")
    #puts doc.collect_namespaces
    # Hash[ doc.root["xsi:schemaLocation"].scan(/(\S+)\s+(\S+)/) ]
    
    schema_final = "<xs:schema xmlns:xs='http://www.w3.org/2001/XMLSchema' elementFormDefault='qualified' attributeFormDefault='unqualified'>"
    doc.xpath("//*[@xsi:schemaLocation]").each do |element|
    
	    schemata_by_ns = Hash[ element["xsi:schemaLocation"].scan(/(\S+)\s+(\S+)/) ]
	    
	      schemata_by_ns.each do |ns,xsd_uri|
	      xsd = Nokogiri::XML::Schema(open(xsd_uri))
	      #puts "NS: #{ns} --- URI: #{xsd_uri}"
	      #puts "VALID: " + xsd.valid?(doc).to_s
	      schema_final += "<xs:import namespace='#{ns}' schemaLocation='#{xsd_uri}'/>"
	      
	    end
	    
    end
    schema_final += "</xs:schema>"
    #puts "SCHEMA FINAL: " + schema_final
    schema2 = Nokogiri::XML::Schema.new(schema_final)
    
    #puts ">>>>> VALID? " + schema2.valid?(doc).to_s
    #schema2.validate(doc).each do |error|
    #    puts error.message
    #end
    
    if schema2.valid?(doc) == true
    	return true
    else
    	return schema2.validate(doc)
    end
    
  end
  
  # Validar la fecha del Comprobante contra la fecha de validez del certificado
  def validate_certificado(xml_file_path)
	
	doc = Nokogiri.XML( File.read(xml_file_path) )
	@no_serie = doc.root.attribute("noCertificado").to_s
	@fecha = doc.root.attribute("fecha").to_s
	@rfc_emisor = doc.root.xpath("//cfdi:Emisor").attribute("rfc").to_s
	puts "RFC Emisor: " + @rfc_emisor
	#puts "No Certificado: " + @no_serie
	#@cert = Cfdcsds.where(:no_serie => @no_serie)
	
	# @TODO: add index to table cfdcsds => no_serie
	@cert = Cfdcsds.find(:first, :conditions => ["no_serie = ?", @no_serie])
	puts @cert.to_json
	
	# 1. validate no_serie exists and is the correct RFC
	if @cert.nil?
		return false
	end
	
	# 2. validate RFC matches certificate RFC
	if @cert.RFC.upcase != @rfc_emisor.upcase
		puts "OPS!! RFC in XML does not match certificate"
		return false
	end
	
	# 3. validate cert date against cfd date
	# testing @cert.fec_final_cert = "2013-01-22T00:41:49Z"
	if Time.parse(@fecha).between?(@cert.fec_inicial_cert, @cert.fec_final_cert) #and @cert.edo_certificado != 'C'
		#puts "YEI, Date between is OK"
	else
		puts "OPS!! Date is not betwen"
		return false
	end
	
  
  end
  
  # Validar el campo de Codigo Postal si existe en SepoMex
  def validate_zipcode(xml_file_path)
  
  	
  
  end
  
  # Validar el estado del Emisor y Receptor
  def validate_state(xml_file_path)
  	
  	doc = Nokogiri.XML( File.read(xml_file_path) )
  	@estado_emisor = doc.root.xpath("//cfdi:Emisor").attribute("rfc").to_s
  	
  	estados = [ 'Aguascalientes', 'Baja California', 'Baja California Sur', 'Campeche', 'Chiapas', 'Chihuahua', 'Coahuila de Zaragoza', 'Coahuila', 'Colima', 'Durango', 'Guanajuato', 'Guerrero', 'Hidalgo', 'Jalisco', 'Mexico', 'México', 'Michoacán de Ocampo', 'Michoacan de Ocampo', 'Michoacán', 'Michoacan', 'Morelos', 'Nayarit', 'Nuevo León', 'Nuevo Leon', 'Oaxaca', 'Puebla', 'Querétaro', 'Queretaro', 'Quintana Roo', 'San Luis Potosí', 'San Luis Potosi', 'Sinaloa', 'Sonora', 'Tabasco', 'Tamaulipas', 'Tlaxcala', 'Veracruz de Ignacio de la Llave', 'Veracruz', 'Yucatán', 'Yucatan', 'Zacatecas', 'Distrito Federal', 'D.F.' ]
  
  end
  
  # Validar serie y folio / Solo para CFDv2.0 y 2.2
  def validate_serie_folio(xml_file_path)
  	
  	doc = Nokogiri.XML( File.read(xml_file_path) )
  	@serie = doc.root.attribute("serie").to_s
  	@folio = doc.root.attribute("folio").to_s
  	
  	# @TODO: add index to table cfdfolios => serie, folioinicial, foliofinal
  	@serfol = Cfdfolios.find(:first, :conditions => ["Serie = ? AND FolioInicial <= ? AND FolioFinal >= ?", @serie, @folio, @folio])
  	
  	if @serfol.nil?
  		puts "OPS!! Folio Not Found"
  		return false
  	else
  		puts @serfol.to_json
  	end
  
  end
  
end
