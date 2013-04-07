# Source: https://blog.heroku.com/archives/2013/2/27/unicorn_rails

worker_processes 3
timeout 30
preload_app true

before_fork do |server, worker|
  Signal.trap "TERM" do
    puts "Unicorn master intercepting TERM, sending QUIT instead"
    Process.kill "QUIT", Process.pid
  end

  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |server, worker|
  Signal.trap "TERM" do
    puts "Unicorn worker intercepting TERM, doing nothing"
  end

  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
