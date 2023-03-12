class EventsController < ApplicationController
  def index
    @events = Event.all
    @events = policy_scope(Event)

    if params[:query].present?
      @events = Event.global_search(params[:query])
      map()
    else
      @events = Event.all
      map()
    end
  end

  def new
    @event = Event.new
    @company = current_user.company
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.company = current_user.company
    authorize @event
    @event.save!
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
    authorize @event
    event = Event.find(params[:id])
    event.destroy
    redirect_to board_path(event), status: :see_other, notice: "Event was successfully deleted."
  end

  private

  def map
    @markers = @events.map do |event|
      { lat: event.company.latitude, lng: event.company.longitude,
        info_window_html: render_to_string(partial: 'info_window', locals: { event: event }) }
    end
  end

  def event_params
    params.require(:event).permit(:title_event, :description_event, :price, :start_date, :end_date, :start_time, :end_time, :company_id)
  end
end
