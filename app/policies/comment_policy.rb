# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
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
