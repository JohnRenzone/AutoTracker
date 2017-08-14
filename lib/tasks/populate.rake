namespace :populate do

  desc 'Populate inventories'
  task :inventories => :environment do
    VehicleReportCard.find_each do |vehicle_report_card|
      unless vehicle_report_card.inventory_exists?
        puts "-----> creating inventory for vin #{vehicle_report_card.vehicle_identification_number}"
        Inventory.decode_vin_and_save(vehicle_report_card.vehicle_identification_number)
      end
    end
  end

  desc 'Populate admin user'
  task :admin => :environment do
    print "Enter E-mail: "
    email = STDIN.gets

    print "Enter Password: "
    password = STDIN.gets

    user = User.create(email: email.strip,
                       password: password.strip,
                       password_confirmation: password.strip,
                       first_name: 'Another',
                       last_name: 'Admin',
                       role: 0)

    if user.errors.present?
      puts 'Failed to create an Admin'
      puts user.errors.full_messages.join(', ')
    else
      puts "An Admin with #{user.email} has been created."
    end
  end
end