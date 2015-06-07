class Dg717Mailer < ActionMailer::Base
  default from: "system@dg717.com"
  layout "mailer"
  def notify_company(company_id, mode)
    @company = Company.find(company_id)
    subject = get_subject(@company)
    @mode = mode
    #mail(to:@company.admin.email, subject:subject)
    mail(to:"schubert-shida@garage.co.jp", subject:subject)
  end

  def get_subject(company)
    company.over_usage? ? "You have used your inclusive monthly allowance for meeting room" : "You have used over 80% of inclusive monthly allowance for meeting room"
  end
end
