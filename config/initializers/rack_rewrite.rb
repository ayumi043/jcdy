# Rails.application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
#   # rewrite   '/wiki/John_Trupiano',  '/comedy'
#   # r301      '/wiki/Yair_Flicker',   '/yair'
#   # r302      '/wiki/Greg_Jastrab',   '/greg'
#   # r301      %r{/wiki/(\w+)_\w+},    '/$1'
# end