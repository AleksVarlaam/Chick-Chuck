namespace :fly do
  desc "Start"
  task :start do 
    sh 'fly ssh console --pty -C "/rails/bin/rails admin:start"'
    sh 'fly ssh console --pty -C "/rails/bin/rails catalog:start"'
    sh 'fly ssh console --pty -C "/rails/bin/rails districts:start"'
  end

  task :console do
    sh 'fly ssh console --pty -C "/rails/bin/rails console"'
  end

  task :dbconsole do
    sh 'fly ssh console --pty -C "/rails/bin/rails dbconsole"'
  end
end
