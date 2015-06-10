class MailPreview < MailView
  # Pull data from existing fixtures
  def notify_company
    company = Company.find 3
    Dg717Mailer.notify_company(company, 0) 
  end
  def notify_company_weekly
    company = Company.find 5
    Dg717Mailer.notify_company(company, 1) 
  end
end