class Event < ApplicationRecord
  belongs_to :company
  has_many :proposals, dependent: :destroy
  has_many :musicians, through: :proposals

  validates :title_event, :start_time, :end_time, :category_event, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, message: "O valor deve ser maior que cero" }
  validates :description_event, presence: true, length: { minimum: 5 }
  validate :end_time_after_start_time
  validate :overlaps_company_events

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: [:title_event], associated_against: { company: [:title] },
                  using: { tsearch: { prefix: true } }
  # pg_search_scope :price_search, against: [:price], using: { tsearch: { prefix: true } }

  CATEGORIES = ['Axé', 'Blues', 'Country', 'Eletrônica', 'Forró', 'Funk', 'Gospel', 'Hip Hop', 'Jazz', 'MPB','Música clássica','Pagode', 'Pop', 'Rap', 'Reggae', 'Rock', 'Samba', 'Sertanejo']

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "Deve ser posterior à data de inicio")
    end
  end

  def overlaps_company_events
    events = Event.all
    incoming_date = (start_time..end_time)
    result = events.find { |event| incoming_date.overlaps?(event.start_time..event.end_time) && event.company == company }

    raise
    return unless result

    errors.add(:start_time, "Já existe evento criado para essa data e/ou horário")
  end
end
