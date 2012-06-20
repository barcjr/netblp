task :deploy do
  raise "Wrong RAILS_ENV" if ENV["RAILS_ENV"] != "production"
  Rake::Task["db:migrate"].invoke
  Rake::Task["assets:precompile"].invoke
  FileUtils.touch "tmp/restart.txt"
end
