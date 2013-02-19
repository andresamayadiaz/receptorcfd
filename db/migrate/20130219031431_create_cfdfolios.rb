class CreateCfdfolios < ActiveRecord::Migration
  def change
    create_table :cfdfolios do |t|
      t.string :RFC
      t.string :NoAprobacion
      t.string :AnoAprobacion
      t.string :Serie
      t.integer :FolioInicial
      t.integer :FolioFinal

      t.timestamps
    end
  end
end
