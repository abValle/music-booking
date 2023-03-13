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

  def new
    @proposal = Proposal.new
    authorize @proposal
  end

  def create
    @proposal = Proposal.new(musician_id: current_user.musician.id, event_id: params[:event_id], winner: nil)
    authorize @proposal
    @proposal.save
    if @proposal.save
      redirect_to proposals_path
    else
      redirect_to events_path, status: :unprocessable_entity, notice: "Você já fez uma proposta para este evento"
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
