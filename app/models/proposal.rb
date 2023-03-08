class Proposal < ApplicationRecord
  belongs_to :musician
  belongs_to :event
end
