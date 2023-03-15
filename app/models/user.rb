class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :musician, dependent: :destroy
  has_one :company, dependent: :destroy
  has_many :messages

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :boolean_company, inclusion: [true, false]
  validates :nickname, presence: true
end
