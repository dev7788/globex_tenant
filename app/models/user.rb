class User < ApplicationRecord
  enum role: [:user, :admin]
  enum state: [:active, :suspend]
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_state, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def set_default_state
    self.state ||= :active
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable
  devise :invitable, :invite_for => 2.weeks
  devise :omniauthable, :omniauth_providers => [:saml]


  def self.find_for_saml_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name: auth.extra.raw_info.my_own_name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
      )
    end
    user
  end

end
