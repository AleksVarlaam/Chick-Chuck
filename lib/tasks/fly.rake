namespace :fly do
  desc "Start"
  task :start => ['admin:start', 'catalog:start', 'districts:start']

  task :console do
    sh 'fly ssh console --pty -C "rails/bin/rails console"'
  end

  task :dbconsole do
    sh 'fly ssh console --pty -C "rails/bin/rails dbconsole"'
  end
end
