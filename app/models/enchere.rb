class Enchere < ApplicationRecord

  belongs_to :objet
  belongs_to :utilisateur

  validates :dateench, presence: true
  validates :prix, presence: true
end
