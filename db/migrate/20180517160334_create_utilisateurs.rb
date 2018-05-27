class CreateUtilisateurs < ActiveRecord::Migration[5.2]
  def change
    create_table :utilisateurs do |t|

      t.string :nomuti
      t.string :prenomuti
      t.string :login
      t.string :password_digest
      t.integer :age
      t.string :rue
      t.integer :codepostal
      t.string :ville
      t.string :remember_digest

      t.timestamps
    end
  end
end
