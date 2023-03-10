class ProposalsController < ApplicationController
  def index
    @proposals = policy_scope(Proposal)
    @proposals = Proposal.all


    if current_user.musician
      @proposals = Proposal.where(musician: current_user.musician)
    else
      @proposals = Proposal.where(event: current_user.company.events)
    end
  end
end
# unless @proposals.nil

#
