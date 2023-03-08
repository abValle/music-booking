class CompaniesController < ApplicationController
  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    authorize @company
  end

  def show
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
end
