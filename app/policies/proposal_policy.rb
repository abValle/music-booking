class ProposalPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
      # user.boolean_company? && current_user == user
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def refuse_proposal?
    true
  end

  def accept_proposal?
    true
  end

end
