require 'bcrypt'
class Utilisateur < ApplicationRecord
  attr_accessor :token #give access to this attribute

  #assoications for commentaire table , create 2 foreign key
  has_many :etrecomments, :class_name => 'Commentaire', :foreign_key => 'uti_becomment_id'
  has_many :comments, :class_name => 'Commentaire', :foreign_key => 'utilisateur_id'
  #user could have multiples objects and bids
  has_many :objets
  has_many :encheres

  validates :nomuti, presence: true
  validates :prenomuti, presence: true
  validates :age, presence: true
  validates :login, presence: true, uniqueness: true

  #password_digest create with this function : secure the password
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password

  # given the password_digest hash
  def digest(string)
    #create a cost witch is use for has password
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                      BCrypt::Engine.cost
    #create password with cost
    BCrypt::Password.create(string, cost: cost)
  end


  # create de new token
  def new_token
    SecureRandom.urlsafe_base64
  end

  #give to remember token for remember utilisateur
  def remember
    self.token = new_token
    #store a condensed of the token
    update_attribute(:remember_digest, digest(token))
  end

  #verifie if the token = remember_digest
  def authenticated(token)
    #test if the attribute remmenber_digest is nil in the bd
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def forgetting
    update_attribute(:remember_digest, nil)
  end

end
