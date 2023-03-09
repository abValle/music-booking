class Company < ApplicationRecord
  belongs_to :user

  has_many :events
  validates :title, :phone, presence: true, uniqueness: true
  validates :address, :category, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validate :permited_phone, if: -> { phone.present? }

  private

  def permited_phone
    errors.add :phone, 'Número incorreto (11999999999)' unless phone.match?(/\A\d{11}\z/)
  end

end
