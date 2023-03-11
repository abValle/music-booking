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

  def create
    @proposal = Proposal.new(proposal_params)
    authorize @proposal
    @proposal.user = current_user
    @proposal.save
    if @proposal.save
      redirect_to proposals_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    authorize @proposal
    @proposal.destroy
    redirect_to proposals_path
  end

  private

  def Proposal_params
    params.require(:proposal).permit( :event_id, :musician_id, :user_id, :winner )
  end
end
