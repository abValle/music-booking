class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    record.company.user == user || user.boolean_company? == false
  end

  def update?
    record.company.user == user
  end

  def destroy?
    record.company.user == user
  end
end
