namespace :scheduler do 
 #Check for usage and send e-mail
  task :daily_notify => :environment do 
    Company.find_each do |company|
      if (company.over_usage? || company.near_limit? ) && company.chargeable?
        Dg717Mailer.notify_company(company.id)
        puts "#{company.name} overused their allowance \n"
      end
    end
  end
end
