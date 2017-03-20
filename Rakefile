require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

if defined?(RSpec)
  task default: :spec
  task spec: 'spec:all'
  namespace :spec do
    task all: ['spec:core',
               'spec:rubocop']

    RSpec::Core::RakeTask.new(:core) do |t|
      t.pattern = 'spec/*_spec.rb'
    end

    RuboCop::RakeTask.new
  end
end
