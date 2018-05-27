class CommentairesController < ApplicationController

  before_action :autorized, only: [:new]

  def new
    #user will be comment
    @utilisateur = Utilisateur.find(params[:utilisateur_id] || params[:id])

    @encheres = []
    @utilisateur.objets.where("datefinench < ?" , DateTime.now).each do |objet|
      #je récupére les dernieres enchereque tous les objets
      @encheres << objet.encheres.last
    end
    #if current user have buy one object
    uti = @encheres.pluck(:utilisateur_id).include?(current_user.id)

    if uti
      @commentaire=Commentaire.new
    else
       render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end

  end

  def create
    #user will be comment by current user
    @utilisateur = Utilisateur.find(params[:utilisateur_id])
    @commentaire = current_user.comments.new(commentaires_params)

    #trigger : if a user would comment himself
    begin
      @commentaire.save
      flash[:notice] = 'Le commentaire à été enregistré'
      redirect_to new_utilisateur_commentaire_path(@utilisateur.id)
    rescue Exception
      flash[:warning] = 'Impossible de commenter cet utilisateur'
      redirect_to  new_utilisateur_commentaire_path(@utilisateur.id)
    end

  end

  def index
    @utilisateur = Utilisateur.find(params[:utilisateur_id] || params[:id])
    @commentaires = Commentaire.where(uti_becomment_id: @utilisateur.id).order(datecomment: :desc)

  end


  private
    def commentaires_params

      params.require(:commentaire).permit(:uti_becomment_id,:utilisateur_id,:datecomment,:commentaire)

    end
  end