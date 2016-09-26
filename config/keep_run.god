rails_env = ENV['RAILS_ENV'] || 'development'
rails_root = ENV['RAILS_ROOT'] || '/home/ubuntu/vanGogh-apprentice'

God.watch do |w|
  w.name = "web"
  w.start = "cd #{rails_root} && rails s -b 0.0.0.0 -e development"
  w.pid_file = File.join(rails_root, "tmp/pids/server.pid")
  w.uid = "ubuntu"
  w.gid = "ubuntu"
  w.behavior(:clean_pid_file)
  w.keepalive
end

God.watch do |w|
  w.name = "delayed_jobs"
  w.start = "cd #{rails_root} && ./bin/delayed_job start"
  w.pid_file = File.join(rails_root, "tmp/pids/delayed_job.pid")
  w.uid = "ubuntu"
  w.gid = "ubuntu"
  w.behavior(:clean_pid_file)
  w.keepalive
end
