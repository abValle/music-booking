class MusiciansController < ApplicationController
  before_action :set_musician, only: %i[show]

  def new
    @musician = Musician.new
    authorize @musician
  end

  def create
    @musician = Musician.new(musician_params)
    @musician.user = current_user
    authorize @musician
    @musician.save
    if @musician.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize(@musician)
  end

  private

  def set_musician
    @musician = Musician.find(params[:id])
  end

  def musician_params
    params.require(:musician).permit( :first_name, :last_name, :phone, :nickname, :address, :category, :birth_date, :description, :phone, :rating, :user_id )
  end

end
