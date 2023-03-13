class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @company = current_user.company unless current_user.nil?
  end

  def profile_musician
    @musician = current_user.musician
  end
end
