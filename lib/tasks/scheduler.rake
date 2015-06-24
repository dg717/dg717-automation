namespace :scheduler do 
 #Check for usage and send e-mail
  task :daily_notify => :environment do 
    Company.find_each do |company|
      if (company.over_usage? || company.near_limit? ) && company.chargeable? && company.send_email?
        Dg717Mailer.notify_company(company.id, 0).deliver
        puts "#{company.name} overused their allowance \n"
        company.mail_sent
      end
    end
  end

  task :weekly_notify => :environment do 
    Company.find_each do |company|
      if company.chargeable?
        DG717Mailer.notify_company(company.id, 1).deliver
      end
    end
  end
end
