# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'railsblogster@gmail.com'
  layout 'mailer'
end
