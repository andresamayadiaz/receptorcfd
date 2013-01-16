class Comprobante < ActiveRecord::Base
  attr_accessible :fecha, :folio, :rfcemisor, :rfcreceptor, :serie, :subtotal, :total, :uuid
end
