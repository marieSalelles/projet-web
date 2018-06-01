class ObjetsController < ApplicationController

  before_action :autorized, only: [:update, :edit, :ventes, :new, :achats, :destroy]

  def new
    @objet=Objet.new
    @categories= Categorie.all
  end

def index
  @categories= Categorie.all
  @objets= Objet.where("datefinench > ?" , DateTime.now)

end


def show
  @objet = Objet.find(params[:id])

  #if not on the market redirection
  if (@objet.datefinench < DateTime.now)
    render(:file => File.join(Rails.root, 'public/Plusenvente.html'), :status => 302, :layout => false)
  else
    @enchere=Enchere.where( objet_id: @objet.id).last
    if @enchere == nil
      @prix = @objet.prix
    else
      @prix = @enchere.prix
    end
  end
end

  def create

    @objet = current_user.objets.new(objet_params)
    @objet.save

    if (params[:objet][:photo] != nil)

      #save the name of image in the database
      @objet.update( photo: @objet.id.to_s)

      begin
        #upload image on cloud
        Cloudinary::Uploader.upload(params[:objet][:photo], :public_id => @objet.id.to_s)
        respond_to do |format|
             format.html {render 'objets/show'}
             format.json {render :show}
        end
      rescue Exception
        flash[:warning] = 'Fichier non valide'
        redirect_to  new_objet_path
      end

    end

  end

  def update
    @objet = Objet.find(params[:id])
    @objet.update(objet_params)

    #recover image in images folder
    if (params[:objet][:photo] != nil)

      #save the name of image in the database
      @objet.update( photo: @objet.id.to_s)

      begin
        #upload image on cloud
        Cloudinary::Uploader.upload(params[:objet][:photo], :public_id => @objet.id.to_s)
        respond_to do |format|
             format.html {render :show}
              format.json {render :show }
        end
      rescue Exception
        flash[:warning] = 'Fichier non valide'
        redirect_to  edit_objet_path
      end


   end
    redirect_to  objet_path
  end

  def edit
    @categories= Categorie.all
    #find object information
    @objet = Objet.find(params[:id])

    #if the usr is not the seller of object 403
    if  current_user.id!= @objet.utilisateur_id
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
  end

  def destroy
    @objet = Objet.find(params[:id])

    if  current_user.id!= @objet.utilisateur_id
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    else
      id = @objet.id
      #delete object, create json response for delete object in the page
      @objet.destroy
      render json: {id: id}
    end

  end

  def ventes
    #object which are on the market
    @objets= Objet.where( utilisateur_id: current_user.id).where("datefinench > ?" , DateTime.now)
    #sold object or object which datefinench is passed
    @objets2= Objet.where( utilisateur_id: current_user.id).where("datefinench < ?" , DateTime.now)
  end

  def achats
    #object which are on the market and user have bids on it
    @objets = []
    Objet.where.not(utilisateur_id: current_user.id).where("datefinench > ?" , DateTime.now).each do |o|
      @objets << o if o.encheres.pluck(:utilisateur_id).include?(current_user.id)
    end

    @objets2 = []
    #sold object or object which datefinench is passed an the last bids was made by user
    Objet.where.not( utilisateur_id: current_user.id).where("datefinench < ?" , DateTime.now).each do |o|
      @objets2 << o if o.encheres.last.utilisateur.id == current_user.id
    end

  end
  private
    def objet_params

      params.require(:objet).permit(:nomobjet, :prix, :description, :datefinench , :categorie_id)

    end
  end



