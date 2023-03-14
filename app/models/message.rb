class Message < ApplicationRecord
  belongs_to :proposal
  belongs_to :user

  validates :content, presence: true
end
