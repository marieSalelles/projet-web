class UtilisateursController < ApplicationController
#not acces to page if not connect
 before_action :set_utilisateur, only: [:edit, :update, :destroy, :show]

 before_action :autorized, only: [:update, :edit, :show]

  def new
    @utilisateur= Utilisateur.new
  end

  def create

    @utilisateur = Utilisateur.new(utilisateur_params)
    @utilisateur.remember
    @utilisateur.save
    logIn @utilisateur
    remember @utilisateur

    respond_to do |format|
      format.html {render :show}
      format.json {render :show }
    end

  end

  def update
    current_user.update(utilisateur_params)
    respond_to do |format|
      format.html {render :show}
      format.json {render :show }
    end
  end

 def edit
  #to_s because param[:id] is a string
   if (params[:id] == current_user.id.to_s)
     render(:edit)
   else
     #non authorized to access to other user modification profile
     render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
   end
 end

 def show
   if (params[:id] == current_user.id.to_s)
     render(:show)
   else
     #non authorized to access to other user's profile
     render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
   end
 end
  private
  def utilisateur_params
    params.require(:utilisateur).permit(:nomuti, :prenomuti, :login, :password, :age, :rue, :codepostal, :ville)
  end

  def set_utilisateur
    @utilisateur=current_user
  end
end
