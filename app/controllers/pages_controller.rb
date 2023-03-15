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
    @musician_proposals = policy_scope(Proposal)
    @musician_proposals = Proposal.all


    if current_user.musician
      @musician_proposals = Proposal.where(musician: current_user.musician)
    else
      @musician_proposals = Proposal.where(event: current_user.company.events)
    end
  end

  def profile_company
    @company = current_user.company
    @resource = current_user
  end
end
