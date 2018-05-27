class Objet < ApplicationRecord

  belongs_to :categorie
  belongs_to :utilisateur
  #an object could have mutiple bids
  has_many :encheres

  validates :nomobjet, presence: true
  validates :prix, presence: true
  validates :description, presence: true
  validates :datefinench, presence: true
  validates :categorie_id, presence: true
  validates :utilisateur_id, presence: true
end
