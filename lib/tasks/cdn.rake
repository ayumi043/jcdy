require 'ftp_sync'
namespace :assets do
  desc 'sync assets to cdns'
  task :cdn => :environment do 
    ftp = FtpSync.new("v0.ftp.upyun.com", "ayumi/jcdysp", "1234abcd", true)
    ftp.sync("#{Rails.root}/public/assets/", "/assets")
  end
end