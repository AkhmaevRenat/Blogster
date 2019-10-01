# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :create, Comment
      can :destroy, Comment do |comment|
        comment.user == user
      end
    end
  end
end
