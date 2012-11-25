root = "/home/moncl/p2p_book_sharing/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_stderr.log"
stdout_path "#{root}/log/unicorn_stdout.log"

listen "/tmp/unicorn.p2p_book_sharing.sock"
worker_processes 2
timeout 30

before_exec do |server| 
  ENV["BUNDLE_GEMFILE"] = "/p2p_book_sharing/current/Gemfile" 
end

