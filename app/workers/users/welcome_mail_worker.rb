# frozen_string_literal: true

class Users::WelcomeMailWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(id)
    @user = User.find(id)
    UserMailer.welcome_email(@user).deliver_now
  end
end
