module SessionsHelper

  def logIn(utilisateur)
    session[:utilisateur_id] = utilisateur.id
  end

  def logOut
    #forget the token for persistant cookie
    forgetting(current_user)
    session.delete(:utilisateur_id)
    @current_user = nil
  end

  # persistent session : remmeber the utilisateur
  def remember(utilisateur)
    utilisateur.remember
    #create crypted permanent cookie
     cookies.permanent.signed[:utilisateur_id] = {:value => utilisateur.id,  :http_only => true }
    #create permanent cookie
    cookies.permanent[:token] = { :value => utilisateur.token , :http_only => true }
  end

  #destroy the persistant cookie => delete cookies of token and cookies of id
  def forgetting(utilisateur)
    utilisateur.forgetting
    cookies.delete(:utilisateur_id)
    cookies.delete(:token)
  end


  # give the current utilisateur.
  def current_user
    if (id = session[:utilisateur_id])
      @current_user ||= Utilisateur.find_by(id: id)
    elsif (id = cookies.signed[:utilisateur_id])
      utilisateur = Utilisateur.find_by(id:  id)
      if utilisateur && utilisateur.authenticated(cookies[:token])
        logIn utilisateur
        @current_user = utilisateur
      end
    end
  end

  def autorized
    redirect_to login_url if current_user.nil?
  end


  # Research if there are e current utilisateur
  def logged_in
    !current_user.nil?
  end

end
