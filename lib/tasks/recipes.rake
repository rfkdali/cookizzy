namespace :recipes do
  desc "Import recipes"
  task import: :environment do
    ImportRecipes.new.call
  end
end
