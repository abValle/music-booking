class EventsController < ApplicationController

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    authorize @event
    @event.save
    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    authorize @event
    redirect_to board_path(event), status: :see_other, notice: "Event was successfully deleted."
  end

  private

  def event_params
    params.require(:event).permit(:title_event, :description_event, :price, :review_musician, :start_date, :end_date, :start_time, :end_time, :company_id)
  end
end
