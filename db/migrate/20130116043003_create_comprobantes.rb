class CreateComprobantes < ActiveRecord::Migration
  def change
    create_table :comprobantes do |t|
      t.string :uuid
      t.string :serie
      t.integer :folio
      t.text :rfcemisor
      t.text :rfcreceptor
      t.datetime :fecha
      t.decimal :total
      t.decimal :subtotal

      t.timestamps
    end
  end
end
