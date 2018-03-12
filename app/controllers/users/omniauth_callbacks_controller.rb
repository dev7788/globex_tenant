class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def saml
    @user = User.find_for_saml_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Salesforce") if is_navigational_format?
    else
      session["devise.saml_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    # session[:important_data] = params.merge(request.env["omniauth.auth"])
    @important_data = params.merge(request.env["omniauth.auth"])
  end

end