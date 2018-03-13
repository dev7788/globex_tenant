class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :verify_authenticity_token, only: :saml

  def saml
    @user = User.find_for_saml_oauth(request.env["omniauth.auth"], current_user)
    unless @user.id?
      @user.save!
    end
    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "simplesamlphp") if is_navigational_format?
  end

end