class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :musicians
  has_many :companies

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
