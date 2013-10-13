namespace :sync do
  task :all do
    RawEmail.sync!
  end
end
task :sync => 'sync:all'
