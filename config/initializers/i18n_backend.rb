if ::Rails.env == "production"
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  $redis = Redis.new
end

I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new($redis), I18n.backend)
