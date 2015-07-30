task default: [:web, :api]

require 'rake'
require 'rspec/core/rake_task'

require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:api) {'rspec spec/*'}

Cucumber::Rake::Task.new(:web)
