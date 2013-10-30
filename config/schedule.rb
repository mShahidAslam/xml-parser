set :output, './cron.log'

every :reboot do
  runner 'Watcher.watch', :environment => 'development'
end