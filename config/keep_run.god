rails_env = ENV['RAILS_ENV'] || 'development'
rails_root = ENV['RAILS_ROOT'] || '/home/ubuntu/vanGogh-apprentice'

God.watch do |w|
  w.name = "web"
  w.start = "cd #{rails_root} && /usr/local/bin/rails s -b 0.0.0.0 -e development"
  w.pid_file = File.join(rails_root, "tmp/pids/server.pid")
  w.uid = "ubuntu"
  w.gid = "ubuntu"
  w.behavior(:clean_pid_file)
  w.keepalive
end

God.watch do |w|
  w.name = "delayed_jobs"
  w.start = "cd #{rails_root} && /usr/local/bin/bundle exec bin/delayed_job start"
  w.stop = "cd #{rails_root} && /usr/local/bin/bundle exec bin/delayed_job stop"
  w.restart = "cd #{rails_root} && /usr/local/bin/bundle exec bin/delayed_job restart"
  w.pid_file = File.join(rails_root, "tmp/pids/delayed_job.pid")
  w.log = "#{rails_root}/log/delayed_job.log"
  w.uid = "ubuntu"
  w.gid = "ubuntu"
  w.behavior(:clean_pid_file)
  w.keepalive
end
