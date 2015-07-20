class StaffPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  permit [:read, :create, :update, :destroy]
end
