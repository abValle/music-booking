class CompaniesController < ApplicationController
  def index
    @company = Company.all
    @company = policy_scope(Company)
  end

  def new
    @company = Company.all
    @company = policy_scope(Company)
  end

  def create
    @company = Company.all
    @company = policy_scope(Company)
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
