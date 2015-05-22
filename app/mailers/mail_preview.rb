class MailPreview < MailView
  # Pull data from existing fixtures
  def notify_company
    company = Company.find 3
    Dg717Mailer.notify_company company 
  end
end