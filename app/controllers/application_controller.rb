class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :rails_ignore_chrome_head_followup

  def rails_ignore_chrome_head_followup
    head :ok and return if request.head?
  end

end
