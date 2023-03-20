class Musician < ApplicationRecord
  belongs_to :user
  has_many :proposals
  validates :first_name, :last_name, :birth_date, :description, :phone, presence: true
  validate :permited_age, if: -> { birth_date.present? }
  validate :permited_phone, if: -> { phone.present? }
  validates :user_id, uniqueness: true
  has_one_attached :photo

  private

  def permited_age
    errors.add :birth_date, 'Necessário ter mais de 18 anos' if (Date.today - 18.years) < birth_date
  end

  def permited_phone
    errors.add :phone, 'Número incorreto (11999999999)' unless phone.match?(/\A\d{11}\z/)
  end
end
