namespace :focal do

  desc "Perform daily metrics import for all projects"
  task import: :environment do
    Burndown.import_all    
  end
end
