CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "ayumi043"
  config.upyun_password = '1234abcd'
  config.upyun_bucket = "jcdysp"
  config.upyun_bucket_domain = "http://v0.api.upyun.com"
end