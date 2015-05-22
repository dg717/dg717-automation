# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, {:error => 'log/cron_error.log', :standard => 'log/cron.log'}
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

#Run the tasks for updating the meetings 
every 5.minutes do 
  rake "yaroomer:get_meetings"
end

#Run the task for updating the accounts
every 1.day, :at => '6:00 am' do 
  rake "yaroomer:update_accounts"
end

#Run the task for monitoring deleted meeting
every :hour do   
  #rake "yaroomer:check_deleted_meetings"
end