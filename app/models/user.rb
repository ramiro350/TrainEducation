class User < ApplicationRecord
  # include Devise::Omniauthable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[keycloakopenid]

  attr_accessor :provider, :first_name, :last_name, :password

  def self.from_omniauth(auth)
    auth = JSON.parse auth.to_json, object_class: OpenStruct
    user = find_or_create_by(uid: auth.uid)
    excluded_roles = ["default-roles-traineducation", "offline_access", "uma_authorization"]

    user.update(
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      provider: auth.provider,
      roles: auth.extra.raw_info.realm_access.roles.reject { |role| excluded_roles.include?(role)},
      password: Devise.friendly_token[0, 20]
    )

    user
  end 
end
