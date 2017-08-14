ActionMailer::Base.default_url_options[:host] = ENV['MAIL_HOST']

# Mail will be sent only if the sendrig account is configured. Else should be collected from log!

if ENV['SENDGRID_USERNAME'].presence and ENV['SENDGRID_PASSWORD'].presence
  puts "=> using sendgrid..."
  ActionMailer::Base.smtp_settings = {
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD'],
      domain: ENV['MAIL_HOST'],
      address: 'smtp.sendgrid.net',
      port: '587',
      authentication: :plain,
      enable_starttls_auto: true}
end

