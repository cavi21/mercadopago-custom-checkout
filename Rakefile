require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts "RuboCop is disabled"
  end
end

task default: [:test, :rubocop]

task :console do
  require 'pry'
  require './lib/mercadopago/custom_checkout'
  require 'httplog'

  def reload!
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/mercadopago\// }
    files.each { |file| load file }
  end

  ARGV.clear
  Pry.start
end
