class DeviseMailer < Devise::Mailer
  helper :application

  def reset_password_instructions(record, token, opts={})
    headers['X-MC-Tags'] = "reset-password"

    super
  end

  def confirmation_instructions(record, token, opts={})
    super
  end
end
