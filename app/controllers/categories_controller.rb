class CategoriesController < ApplicationController
  def new
    @categorie=Categorie.new
  end

  def show
    @categorie = Categorie.find(params[:id])
    @categories= Categorie.all
    #select object by category
    @objets= Objet.where(categorie_id:  params[ :id]).where("datefinench > ?" , DateTime.now)


  end

end
