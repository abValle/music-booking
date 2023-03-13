class Event < ApplicationRecord
  belongs_to :company
  has_many :proposals, dependent: :destroy
  has_many :musicians, through: :proposals

  validates :title_event, :start_date, :end_date, :start_time, :end_time, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, message: "O valor deve ser maior que cero" }
  validates :description_event, presence: true, length: { minimum: 5 }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: [:title_event], associated_against: { company: [:title] },
                  using: { tsearch: { prefix: true } }

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "Deve ser posterior à data de inicio")
    end
  end

  def end_time_after_start_time
    return if end_date.blank? || start_date.blank?

    if end_time < start_time
      errors.add(:end_time, "Deve ser depois da hora de inicio")
    end
  end
end
