class ResetMailer < ActionMailer::Base
  default :from => "jsveholm@fir.riec.tohoku.ac.jp"

  def reset_confirmation(reset)
    @reset_url = reset_password_user_url(reset.user, :code => reset.code, :host => "localhost")
    mail(:to => reset.user.email, :subject => "Password Reset")
  end
end