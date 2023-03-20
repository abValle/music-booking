class MusicianPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def update?
    record.user == user
  end

  def create?
    !user.boolean_company && user.musician.nil?
  end

  def show?
    true
  end

  def new?
    true
  end
end
