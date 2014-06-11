require 'rspec/core/rake_task'

task :default => :play

desc "Play connect four game"
task :play do
	ruby "-w lib/connect_four.rb"
end

desc "Run tests of connect four game"
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = "-c -w"
	t.verbose = false
end
