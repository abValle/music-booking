class ProposalChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    proposal = Proposal.find(params[:id])
    stream_for proposal
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
