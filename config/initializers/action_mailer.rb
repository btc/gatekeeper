Vern::Application.configure do

  config.action_mailer.default_url_options = { :host => 'vip.zen.tt' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default from: 'no-reply@zen.tt'
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'vip.zen.tt',
    :user_name            => 'zen.engineering.tests@gmail.com',
    :password             => 'buddha12345',
    :authentication       => 'plain',
    :enable_starttls_auto => true
  }

end
