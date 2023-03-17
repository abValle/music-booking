class Company < ApplicationRecord
  belongs_to :user
  geocoded_by :address # usar o address para a geolocalizacao
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :events, dependent: :destroy
  validates :title, :phone, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true, length: { minimum: 5 }
  validate :permited_phone, if: -> { phone.present? }
  validates :user_id, uniqueness: true
  has_one_attached :photo


  private

  def permited_phone
    errors.add :phone, 'Número incorreto (11999999999)' unless phone.match?(/\A\d{11}\z/)
  end
end
