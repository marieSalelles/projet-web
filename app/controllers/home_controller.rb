class HomeController < ApplicationController
  def index
    @objets= Objet.where("datefinench > ?" , DateTime.now).order(created_at: :asc).last(6)
    @categories= Categorie.all

  end
end
