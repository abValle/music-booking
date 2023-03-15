class Message < ApplicationRecord
  belongs_to :proposal
  belongs_to :user

  validates :content, presence: true

  after_create :push_notification

  private

  def push_notification
    recipient = if self.user == self.proposal.musician.user
      self.proposal.event.company.user
    else
      self.proposal.musician.user
    end

    push = Push.new(user: recipient, subject: "You have message from #{self.user.nickname}")
    push.save
  end
end
