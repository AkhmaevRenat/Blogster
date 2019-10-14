# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def destroy?
    return true if user.present? && user == comment.user
  end

  private

  def comment
    record
  end
end
