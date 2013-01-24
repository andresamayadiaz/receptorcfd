class Comprobante < ActiveRecord::Base
  
  require 'nokogiri'
  require 'open-uri'
  
  attr_accessible :fecha, :folio, :rfcemisor, :rfcreceptor, :serie, :subtotal, :total, :uuid
  
  def validate
    
    # open("http://www.sat.gob.mx/cfd/3/cfdv32.xsd")
    doc = Nokogiri::XML( File.read("/Users/andresamayadiaz/Documents/rails/receptorcfd/public/comprobante32.xml") )
    
    #puts "KEYS: " + doc.root.keys.to_s
    #puts "Schema: " + doc.root["xsi:schemaLocation"]
    #puts doc.xpath("//*[@xsi:schemaLocation]")
    
    schemata_by_ns = Hash[ doc.root["xsi:schemaLocation"].scan(/(\S+)\s+(\S+)/) ]
    schema_final = "<xs:schema xmlns:xs='http://www.w3.org/2001/XMLSchema' elementFormDefault='qualified' attributeFormDefault='unqualified'>"
    schemata_by_ns.each do |ns,xsd_uri|
      xsd = Nokogiri::XML::Schema(open(xsd_uri))
      #puts "NS: #{ns} --- URI: #{xsd_uri}"
      #puts "VALID: " + xsd.valid?(doc).to_s
      schema_final += "<xs:import namespace='#{ns}' schemaLocation='#{xsd_uri}'/>"
=begin      
      xsd.validate(doc).each do |error|
        puts error.message
      end
=end
      #puts ""
    end
    schema_final += "</xs:schema>"
    #puts "SCHEMA FINAL: " + schema_final
    schema2 = Nokogiri::XML::Schema.new(schema_final)
    puts ">>>>> " + schema2.valid?(doc).to_s
    schema2.validate(doc).each do |error|
        puts error.message
    end
  end
  
end
