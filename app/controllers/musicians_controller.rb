class MusiciansController < ApplicationController
  before_action :set_musician, only: %i[show edit update]
  before_action :set_authorize, only: %i[show edit update]

  def new
    @musician = Musician.new
    authorize(@musician)
  end

  def edit; end

  def update
    if @musician.update(musician_params)
      redirect_to root_path, notice: "Atualização efetuada!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @musician = Musician.new(musician_params)
    authorize(@musician)
    @musician.user = current_user
    if @musician.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_musician
    @musician = Musician.find(params[:id])
  end

  def set_authorize
    authorize(@musician)
  end

  def musician_params
    musician_params = %i[first_name last_name phone nickname address category birth_date description phone rating photo]
    params.require(:musician).permit(musician_params)
  end
end
