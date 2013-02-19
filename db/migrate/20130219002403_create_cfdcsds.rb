class CreateCfdcsds < ActiveRecord::Migration
  def change
    create_table :cfdcsds do |t|
      t.string :no_serie, :null => false
      t.timestamp :fec_inicial_cert, :null => false
      t.timestamp :fec_final_cert, :null => false
      t.string :RFC, :null => false
      t.string :edo_certificado, :null => false

      t.timestamps
    end
  end
end
