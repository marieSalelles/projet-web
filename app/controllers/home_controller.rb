class HomeController < ApplicationController
  def index
    @objets= Objet.where("datefinench > ?" , DateTime.now).order(:created_at).limit(6)
    @categories= Categorie.all

  end
end
