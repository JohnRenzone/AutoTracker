web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb

# See config/unicorn.rb for disabling spawing of workers in web dyno
worker: bundle exec sidekiq -q default -q mailer -c 2 -C config/sidekiq.yml