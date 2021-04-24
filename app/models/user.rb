class User < ApplicationRecord
  attr_writer :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[facebook], authentication_keys: [:login]

  validates_uniqueness_of :mobile_number

  def login
    @login || self.mobile_number || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["mobile_number = :value OR email = :value", { :value => login }]).first
    elsif conditions.has_key?(:mobile_number) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

end
