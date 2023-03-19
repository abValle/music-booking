class ProposalsController < ApplicationController
  def index
    # @proposals = Proposal.where(musician: current_user.musician).and(Proposal.where(winner: true)).includes(:event)
    @proposals = policy_scope(Proposal)
    @company = current_user.company
    if current_user.musician
      # @proposals = Proposal.where(musician: current_user.musician)
      @proposals = Proposal.where(musician: current_user.musician).and(Proposal.where(winner: nil)).includes(:event)
    else
      # @proposals = Proposal.where(event: current_user.company.events)
      @proposals = Proposal.where(event: current_user.company.events).and(Proposal.where(winner: nil)).includes(:event)
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
    @push = Push.where(proposal_id: @proposal.id).and(Push.where(user_id: current_user.id))
    @message = Message.new
    authorize @proposal
    @push.destroy_all
  end


  def new
    @proposal = Proposal.new
    authorize @proposal
  end

  def create
    @proposal = Proposal.new(musician: current_user.musician, event_id: params[:event_id], winner: nil)
    authorize @proposal
    @proposal.save
    @musician_user = @proposal.musician.user
    @company_nickname = @proposal.event.company.user.nickname
    Message.create(proposal_id: @proposal.id, user_id: @musician_user.id, content:
      "::MENSAGEM PADRONIZADA DA MUSIC BOOKING:: OLÁ '#{@company_nickname}' o musico:' #{@musician_nickname}'enviou uma proposta, e tem interesse no evento:'#{@proposal.event.title_event}'.
      Que tal se conhecerem melhor? E acertarem detalhes para fechar negócio?")

    if @proposal.save
      redirect_to profile_musician_path
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

  def refuse_proposal
    @proposal = Proposal.find(params[:id])
    authorize @proposal
    @proposal.winner = false
    @proposal.save
    @company_user = @proposal.event.company.user
    @musician_nickname = @proposal.musician.user.nickname
    Message.create(proposal_id: @proposal.id, user_id: @company_user.id, content:
      "::MENSAGEM PADRONIZADA DA MUSIC BOOKING::
      OLÁ '#{@musician_nickname}' Infelizmente A CIA:' #{@proposal.event.company.title}' recusou a sua proposta para o evento:'#{@proposal.event.title_event}'.
      Mas fique tranquilo que ainda tem muitas oportunidades por aí! ;]")


    redirect_to profile_company_path
  end

  def accept_proposal
    @proposal = Proposal.find(params[:id])
    authorize @proposal
    @proposal.winner = true
    @proposal.save
    @company_user = @proposal.event.company.user
    @musician_nickname = @proposal.musician.user.nickname
    Message.create(proposal_id: @proposal.id, user_id: @company_user.id, content:
      "::MENSAGEM PADRONIZADA DA MUSIC BOOKING:: OLÁ '#{@musician_nickname}' ESTAMOS FELIZES EM COMUNICAR QUE A CIA:' #{@proposal.event.company.title}'APROVOU A SUA PROPOSTA PARA O EVENTO #{@proposal.event.title_event}!
       *confira mais detalhes no seu perfil em 'Propostas Aceitas' :)")

    redirect_to profile_company_path
  end

  def cancel_proposal

    @proposal = Proposal.find(params[:id])
    authorize @proposal

    @proposal.winner = false
    @proposal.save

    @company_user = @proposal.event.company.user
    @company_nickname = @proposal.event.company.user.nickname

    @musician_user = @proposal.musician.user
    @musician_nickname = @proposal.musician.user.nickname

    Message.create(proposal_id: @proposal.id, user_id: @musician_user.id, content:
      "::MENSAGEM PADRONIZADA DA MUSIC BOOKING:: OLÁ '#{@company_nickname}' Infelizmente o musico:' #{@musician_nickname}' recusou a sua proposta para o evento:'#{@proposal.event.title_event}'.
       Mas fique tranquilo que ainda tem muitos musicos por aí! ;]")

    redirect_to profile_musician_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:proposal_id, :event_id, :musician_id, :user_id, :winner )
  end
end
