class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@mydomain.com'
  layout 'mailer'
end
