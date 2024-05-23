class CreateMilitars < ActiveRecord::Migration[7.1]
  def change
    create_table :militars do |t|
      t.string :nombre
      t.boolean :oficial
      t.string :usuario
      t.string :nombre_superior

      t.timestamps
    end
  end
end
