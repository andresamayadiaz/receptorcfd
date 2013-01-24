class Comprobante < ActiveRecord::Base
  
  require 'nokogiri'
  require 'open-uri'
  require 'mysql2'
  
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
    puts "SCHEMA FINAL: " + schema_final
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
  
  		client = Mysql2::Client.new(:host => "192.168.100.251", :username => "root", :password => "ceis12345", :port => 3306, :database => "facturasoft")
  		puts "CLIENT: " + client.inspect
  		results = client.query("SELECT * FROM cfdfolios LIMIT 10")
  		puts results.count
  		results.each do |row|
		  # conveniently, row is a hash
		  # the keys are the fields, as you'd expect
		  # the values are pre-built ruby primitives mapped from their corresponding field types in MySQL
		  # Here's an otter: http://farm1.static.flickr.com/130/398077070_b8795d0ef3_b.jpg
		  
		  puts row.to_s
		  
		end
  
  end
  
  # Validar el campo de Codigo Postal si existe en SepoMex
  def validate_zipcode(xml_file_path)
  
  	
  
  end
  
  # Validar serie y folio / Solo para CFDv2.0+
  def validate_serie_folio(xml_file_path)
  
  	
  
  end
  
end
