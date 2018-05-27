class EncheresController < ApplicationController

  before_action :autorized, only: [:new]

  def new
    @objet = Objet.find(params[:objet_id] || params[:id])

    #if not on the market redirection
    if (@objet.datefinench < DateTime.now)
      render(:file => File.join(Rails.root, 'public/Plusenvente.html'), :status => 302, :layout => false)
    else

      #user who have put this object on the market don't have bids on it
      # if  current_user.id== @objet.utilisateur_id
      #   render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
      # end
      # #select the last bids on this object
      @enchereExist = Enchere.where(objet_id: @objet.id).last

      #initialization last price
      if @enchereExist == nil
        @prix = @objet.prix
      else
        @prix = @enchereExist.prix
      end
    end
    @enchere=Enchere.new
  end

  def create
    @objet = Objet.find(params[:objet_id])

    @enchere = current_user.encheres.new(enchere_params)

    begin
      @enchere.save
      flash[:notice] = 'L\'enchere a été prise en compte'
      redirect_to new_objet_enchere_path(@objet.id)
    rescue Exception
      flash[:warning] = 'L\'enchere est impossible '
      redirect_to new_objet_enchere_path(@objet.id)
    end


    #redirect_to objet_url(@objet)
  end

  def index
    @objet = Objet.find(params[:objet_id] || params[:id])

    #if not on the market redirection
    if (@objet.datefinench < DateTime.now)
      render(:file => File.join(Rails.root, 'public/Plusenvente.html'), :status => 302, :layout => false)
    else
      @encheres = Enchere.where(objet_id: @objet.id).order(dateench: :desc)
    end
  end

  private
    def enchere_params

      params.require(:enchere).permit(:prix,:dateench, :objet_id)

    end
  end
