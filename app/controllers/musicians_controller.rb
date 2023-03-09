class MusiciansController < ApplicationController
  before_action :set_musician, only: %i[show]

  def show
    authorize(@musician)
  end

  private

  def set_musician
    @musician = Musician.find(params[:id])
  end
end
