namespace :yaroomer do 

  task :get_meetings => :environment do 
    yaroom = Yaroomer.new
    yaroom.get_meetings
  end

  #Get the accounts 
  task :get_accounts => :environment do 
    yaroom = Yaroomer.new
    yaroom.get_accounts
  end

  #TODO: check the deleted meetings, if deleted within 3 hours then flag it.
  task :check_deleted_meetings => :environment do 
    yaroom = Yaroomer.new
    yaroom.check_deletd_meetings
  end

end