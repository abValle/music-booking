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
    authorize @company
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
  end

  def destroy
    authorize @company
  end

  private

  def company_params
    params.require(:company).permit( :title, :category, :phone, :description, :address, :user_id )
  end
end
