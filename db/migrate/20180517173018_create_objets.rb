class CreateObjets < ActiveRecord::Migration[5.2]
  def change
    create_table :objets do |t|
      t.string :nomobjet
      t.decimal :prix
      t.string :photo
      t.text :description
      t.datetime :datefinench
      t.belongs_to :categorie, foreign_key: true
      t.belongs_to :utilisateur, foreign_key: true
      t.timestamps
    end
  end
end
