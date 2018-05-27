class ObjetsController < ApplicationController

  before_action :autorized, only: [:update, :edit, :ventes, :new, :achats]

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

      #upload image on cloud
      Cloudinary::Uploader.upload(params[:objet][:photo], :public_id => @objet.id.to_s)

    end


    respond_to do |format|
      format.html {render 'objets/show'}
      format.json {render :show}
    end

  end

  def update
    @objet = Objet.find(params[:id])
    @objet.update(objet_params)

    #recover image in images folder
    if (params[:objet][:photo] != nil)

      #save the name of image in the database
      @objet.update( photo: @objet.id.to_s)

      #upload image on cloud
      Cloudinary::Uploader.upload(params[:objet][:photo], :public_id => @objet.id.to_s)



   end

    respond_to do |format|
      format.html {render :show}
      format.json {render :show }
    end
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
    #if this object no have bid

  end

  def ventes
    #object which are on the market
    @objets= Objet.where( utilisateur_id: current_user.id).where("datefinench > ?" , DateTime.now)
    #sold object or object which datefinench is passed
    @objets2= Objet.where( utilisateur_id: current_user.id).where("datefinench < ?" , DateTime.now)
  end

  def achats
    #object which are on the market and user have bids on it
    @objets= Objet.where.not(utilisateur_id: current_user.id).where("datefinench > ?" , DateTime.now)
    #sold object or object which datefinench is passed an the last bids was made by user
    @objets2= Objet.where.not( utilisateur_id: current_user.id).where("datefinench < ?" , DateTime.now)


   # @objets2.each do |objet|
    #    @enchere = Enchere.where(objet_id: objet.id).last
     # if @enchere.utilisateur_id == current_user.id
      #  @encheres = @enchere
     # end
   # end

  end
  private
    def objet_params

      params.require(:objet).permit(:nomobjet, :prix, :description, :datefinench , :categorie_id)

    end
  end



