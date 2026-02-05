namespace :dev do
  desc "Configure development environment"
  task setup: :environment do
    puts "Setting up development database..."
    %x(rails db:drop db:create db:migrate db:seed)
    puts "Success!"
  end

end
