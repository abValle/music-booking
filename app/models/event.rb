class Event < ApplicationRecord
  belongs_to :company
  has_many :proposals, dependent: :destroy
  has_many :musicians, through: :proposals

  before_validation :verificar_request

  validates :title_event, :start_time, :end_time, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, message: "O valor deve ser maior que cero" }
  validates :description_event, presence: true, length: { minimum: 5 }

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[title_event category_event], associated_against: { company: [:title] },
                  using: { tsearch: { prefix: true } }

  CATEGORIES = %w[Axé Blues Country Eletrônica Forró Funk Gospel Hip-Hop Jazz MPB
                  Música-Clássica Pagode Pop Rap Reggae Rock Samba Sertanejo].sort!

  private

  def data_validates
    return if end_time.nil? || start_time.nil?

    if end_time < start_time
      errors.add(:end_time, "Deve ser posterior à data de inicio")
    else
      overlaps_company_events
    end
  end

  def verificar_request
    if id
      @events = Event.where.not(id:).all
    else
      @events = Event.all
    end
    data_validates
  end

  def overlaps_company_events
    incoming_date = (start_time..end_time)
    result = @events.find { |event| incoming_date.overlaps?(event.start_time..event.end_time) && event.company == company }
    if result.nil?
      return
    else
      errors.add(:start_time, "Já existe evento criado para essa data e/ou horário")
    end
  end
end
