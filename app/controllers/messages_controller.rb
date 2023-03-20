class MessagesController < ApplicationController
    def create
      @proposal = Proposal.find(params[:proposal_id])
      @message = Message.new(message_params)
      authorize @message
      @message.proposal = @proposal
      @message.user = current_user
      if @message.save
        ProposalChannel.broadcast_to(
          @proposal,
          render_to_string(partial: "message", locals: {message: @message})
        )
        head :ok
      else
        render "proposals/show", status: :unprocessable_entity
      end
    end

    private

    def message_params
      params.require(:message).permit(:content)
    end
end
