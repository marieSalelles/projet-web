class CreateCommentaires < ActiveRecord::Migration[5.2]
  def change
    create_table :commentaires do |t|
      t.references :uti_becomment
      t.references :utilisateur
      t.datetime :datecomment
      t.text :commentaire
      t.timestamps
    end
  end
end
