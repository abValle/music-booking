class MusicianPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    !user.boolean_company
  end

  def show?
    record.user == user
  end
end
