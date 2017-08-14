Rails.application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  rewrite %r{assets/(css|fonts|images|js|plugins)/(.*)}, 'assets/$2'
end