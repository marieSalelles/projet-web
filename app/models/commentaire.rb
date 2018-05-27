class Commentaire < ApplicationRecord

  #associations with utilisateur table
  belongs_to :uti_becomment, class_name: 'Utilisateur', foreign_key: 'uti_becomment_id'
  belongs_to :uti_comment, class_name: 'Utilisateur', foreign_key: 'utilisateur_id'



end
