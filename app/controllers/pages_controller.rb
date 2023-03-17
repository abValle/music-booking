class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @company = current_user.company unless current_user.nil?
  end

  def profile_musician
    @musician = current_user.musician

    @accepted_proposals = Proposal.where(musician: current_user.musician).and(Proposal.where(winner: true)).includes(:event)
    @refused_proposals = Proposal.where(musician: current_user.musician).and(Proposal.where(winner: false)).includes(:event)
    @pending_proposals = Proposal.where(musician: current_user.musician).and(Proposal.where(winner: nil)).includes(:event)

    @my_proposals = policy_scope(Proposal)
    @my_proposals = Proposal.all

    if current_user.musician
      @my_proposals = Proposal.where(musician: current_user.musician)
    else
      @my_proposals = Proposal.where(event: current_user.company.events)
    end
  end

  def profile_company

    @company = current_user.company
    @resource = current_user

    @accepted_proposals = Proposal.where(event_id: current_user.company.events).and(Proposal.where(winner: true)).includes(:event)
    @refused_proposals = Proposal.where(event_id: current_user.company.events).and(Proposal.where(winner: false)).includes(:event)
    @pending_proposals =  Proposal.where(event: current_user.company.events).and(Proposal.where(winner: nil)).includes(:event)

    @my_proposals = Proposal.where(event: current_user.company.events).and(Proposal.where(winner: nil)).includes(:event)
  end

  private

  def proposal_params
    params.require(:proposal).permit(:proposal_id, :event_id, :musician_id, :user_id, :winner )
  end
end
