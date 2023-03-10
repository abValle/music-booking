class Proposal < ApplicationRecord
  belongs_to :musician
  belongs_to :event

  validates :musician_id, uniqueness: { scope: :event_id, message: "Você já fez uma proposta para esse evento." }
end
