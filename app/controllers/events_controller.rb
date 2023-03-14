class EventsController < ApplicationController
  def index
    @events = Event.all
    @events = policy_scope(Event)
    @proposal = Proposal.new

    search_filter
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
    @event.save
    if @event.save
      redirect_to profile_company_path, notice: "Event was successfully created."
    else
    render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
    @proposal = Proposal.new
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

  def search_filter
    if params[:query].present?
      @events = @events.global_search(params[:query]).order(price: :desc)
    end

    if params[:price].present?
      if params[:price] == 1100
        @events = @events.where("price >= ?", params[:price]).order(price: :desc)
      else
        @events = @events.where("price <= ?", params[:price]).order(price: :desc)
      end
    end

    if params[:address].present?
      companies_ids = Company.near(params[:address], 4).map(&:id)
      @events = @events.where(company_id: companies_ids)
    end

    # if params[:start_time].present? || params[:end_time].present?
    #   # TODO filtro por data
    # end

    map()
  end
end
