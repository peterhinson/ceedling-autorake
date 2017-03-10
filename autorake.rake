
desc "Automatically test changed sources"
task :auto do
  @ceedling[:autorake].load("project.yml")
end

