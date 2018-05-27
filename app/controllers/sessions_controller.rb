class SessionsController < ApplicationController
  def new

  end
  def create
    #search if login is in the bd / login is in lowercase in the bd
    utilisateur = Utilisateur.find_by(login: params[:session][:login].downcase)
    #test if utilisateur is not nil then compare password
    if utilisateur && utilisateur.authenticate(params[:session][:password])
      logIn utilisateur
      remember utilisateur
      redirect_to utilisateur
    else

      render 'new'
    end
  end
  def destroy
    #we can deconnect if we are connect
    logOut if logged_in
    redirect_to root_url
  end
end
