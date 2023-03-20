class CompaniesController < ApplicationController

  def index
    @company = Company.all
    @company = policy_scope(Company)
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    @company.user = current_user
    @company.save
    if @company.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @company = Company.find(params[:id])
    authorize @company
  end

  def edit
    @company = current_user.company
    authorize @company
  end

  def update
    @company = current_user.company
    authorize @company
    @company.update(company_params)
    if @company.save
      redirect_to profile_company_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:instagram_url, :facebook_url, :soundcloud_url, :spotify_url, :youtube_url, :title, :phone, :description, :address, :user_id, :photo, category: []).tap do |whitelisted|
      whitelisted[:category] = params[:company][:category].compact_blank!.join(", ")
    end
  end
end
