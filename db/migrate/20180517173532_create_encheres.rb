class CreateEncheres < ActiveRecord::Migration[5.2]
  def change
    create_table :encheres do |t|
      t.belongs_to :objet, foreign_key: true
      t.belongs_to :utilisateur, foreign_key: true
      t.datetime :dateench
      t.decimal :prix
      t.timestamps
    end
  end
end
