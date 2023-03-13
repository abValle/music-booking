class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @company = current_user.company unless current_user.nil?
  end

  def profile_musician
    @musician = current_user.musician
    @proposals = Proposal.where(musician: current_user.musician).and(Proposal.where(winner: true)).includes(:event)

  end

  def profile_company
    @company = current_user.company
  end
end
