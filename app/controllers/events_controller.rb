class EventsController < ApplicationController
  def index
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
    map()
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to event_path(@event), status: :see_other, notice: "Event was successfully deleted."
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
    @company = @event.company
  end

  def update
    @event = Event.find(params[:id])
    authorize(@event)
    if @event.update(event_params)
      redirect_to company_path(@event.company), notice: "Atualização efetuada!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def map
    if @events
      @markers = @events.map do |event|
        { lat: event.company.latitude, lng: event.company.longitude,
          info_window_html: render_to_string(partial: 'info_window', locals: { event: event }) }
      end
    else
      @markers = [{ lat: @event.company.latitude, lng: @event.company.longitude,
                    info_window_html: render_to_string(partial: 'info_window', locals: { event: @event }) }]
    end
  end

  def event_params
    params.require(:event).permit(:title_event, :description_event, :price, :start_time, :end_time, category_event: []).tap do |whitelisted|
      whitelisted[:category_event] = params[:event][:category_event].compact_blank!.join(", ")
    end
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

    if params[:start_time].present?
      @events = @events.where('DATE(start_time) = ?', params[:start_time])
    end
    map()
  end
end
